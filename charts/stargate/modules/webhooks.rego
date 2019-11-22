package webhooks

# https://github.com/open-policy-agent/opa/issues/1588
# merge a and b to produce c. b's values override a's values.
merge(a, b) = c {
  keys := {k | some k; _ = a[k]} | {k | some k; _ = b[k]}
  c := {k: v | k := keys[_]; v := pick(k, b, a)}
}
# return k from first obj that contains it.
pick(k, obj1, _) = obj1[k]
pick(k, obj1, obj2) = obj2[k] { not exists(obj1, k) }
exists(obj, k) { _ = obj[k] }

event = e {
  input.headers["X-Github-Event"][_] = "pull_request"
  repo = lower(input.payload.repository.name)
  e := {
    "eventType": "pull_request",
    "eventAction": input.payload.action,
    "eventUUID": input.headers["X-Stargate-Request-Id"][0],
    "repository": {
      "id": sprintf("pr-%d", [input.payload.pull_request.number]),
      "name": repo,
      "url": input.payload.pull_request.head.repo.clone_url,
      "revision": input.payload.pull_request.head.sha,
      "branch": input.payload.pull_request.head.ref,
      "fullName": input.payload.repository.full_name,
    }
  }
}

event = e {
  input.headers["X-Github-Event"][_] = "push"
  repo = lower(input.payload.repository.name)
  branch = trim_prefix(input.payload.ref, "refs/heads/")
  e := {
    "eventType": "push",
    "eventAction": "push",
    "eventUUID": input.headers["X-Stargate-Request-Id"][0],
    "repository": {
      "id": branch,
      "name": repo,
      "url": input.payload.repository.clone_url,
      "revision": input.payload.head_commit.id,
      "branch": branch,
      "fullName": input.payload.repository.full_name,
    }
  }
}

event = e {
  input.headers["X-Gitlab-Event"][_] = "Push Hook"
  repo = lower(input.payload.project.name)
  branch = trim_prefix(input.payload.ref, "refs/heads/")
  e := {
    "eventType": "push",
    "eventAction": "push",
    "eventUUID": input.headers["X-Stargate-Request-Id"][0],
    "repository": {
      "id": branch,
      "name": repo,
      "url": input.payload.repository.git_http_url,
      "revision": input.payload.checkout_sha,
      "branch": branch,
      "fullName": input.payload.project.path_with_namespace
    }
  }
}

event = e {
  input.headers["X-Gitlab-Event"][_] = "Merge Request Hook"
  repo = lower(input.payload.project.name)
  branch = input.payload.object_attributes.source_branch
  e := {
    "eventType": "pull_request",
    "eventAction": input.payload.object_attributes.state,
    "eventUUID": input.headers["X-Stargate-Request-Id"][0],
    "repository": {
      "id": sprintf("pr-%d", [input.payload.object_attributes.id]),
      "name": repo,
      "url": input.payload.object_attributes.source.git_http_url,
      "revision": input.payload.object_attributes.last_commit.id,
      "branch": branch,
      "fullName": input.payload.object_attributes.source.path_with_namespace
    }
  }
}

default run_stage1 = false
run_stage1 {
  event.eventType = "pull_request"
  event.eventAction = "opened"
}
run_stage1 {
  event.eventType = "pull_request"
  event.eventAction = "synchronized" # github
}
run_stage1 {
  event.eventType = "pull_request"
  event.eventAction = "updated" # gitlab
}
run_stage1 {
  event.eventType = "push"
  event.repository.branch = "master"
}

default superuser = false
superuser {
  event.eventType = "push"
  event.repository.branch = "master"
}

event_stage1 = e {
  e := merge(event, {"namespace": sprintf("ci-%s-%s", [event.repository.name, event.repository.id])})
}

default r = []
resources[r] {
  run_stage1
  saName = sprintf("ci-%s-%s", [event.repository.name, event.repository.id])
  roleName = sprintf("ci-role-%s-%s", [event.repository.name, event.repository.id])
  taskName = sprintf("ci-stage2-%s-%s-", [event.repository.name, event.repository.id])
  r := [
    {
      "apiVersion": "v1",
      "kind": "Namespace",
      "metadata": {
        "name": "tekton-pipelines-stage2",
      }
    },
    {
      "apiVersion": "v1",
      "kind": "ServiceAccount",
      "metadata": {
        "name": saName,
        "namespace": "tekton-pipelines-stage2",
        "annotations": {
          "ci/superuser": sprintf("%s", [superuser])
        }
      }
    },
    {
      "apiVersion": "rbac.authorization.k8s.io/v1beta1",
      "kind": "ClusterRoleBinding",
      "metadata": {
        "name": roleName,
      },
      "roleRef": {
        "apiGroup": "rbac.authorization.k8s.io",
        "kind": "ClusterRole",
        "name": "tekton-ci-stage2"
      },
      "subjects": [
        {
          "kind": "ServiceAccount",
          "name": saName,
          "namespace": "tekton-pipelines-stage2"
        }
      ]
    },
    {
      "apiVersion": "tekton.dev/v1alpha1",
      "kind": "TaskRun",
      "metadata": {
        "generateName": taskName,
        "namespace": "tekton-pipelines-stage2",
        "labels": {
            "ci/event-uuid": event.eventUUID,
            "ci/project": event.repository.name
        }
      },
      "spec": {
        "serviceAccount": saName,
        "taskRef": {
          "name": "ci-stage2"
        },
        "inputs": {
          "params": [
            { "name": "event", "value": json.marshal(event_stage1) },
            { "name": "repoName", "value": event.repository.name },
            { "name": "repoID", "value": event.repository.id }
          ],
          "resources": [
            {
              "name": "project-repo",
              "resourceSpec": {
                "type": "git",
                "params": [
                  {
                    "name": "url",
                    "value": event.repository.url
                  },
                  {
                    "name": "revision",
                    "value": event.repository.revision
                  }
                ]
              }
            }
          ]
        }
      }
    }
  ]
}
