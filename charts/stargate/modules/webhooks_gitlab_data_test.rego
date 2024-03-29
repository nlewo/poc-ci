package webhooks

gitlab_push(branch) = event {
  event := {
    "payload": {
      "object_kind": "push",
      "before": "95790bf891e76fee5e1747ab589903a6a1f80f22",
      "after": "da1560886d4f094c3e6c9ef40349f7d38b5d27d7",
      "ref": sprintf("refs/heads/%s", [branch]),
      "checkout_sha": "da1560886d4f094c3e6c9ef40349f7d38b5d27d7",
      "user_id": 4,
      "user_name": "John Smith",
      "user_username": "jsmith",
      "user_email": "john@example.com",
      "user_avatar": "https://s.gravatar.com/avatar/d4c74594d841139328695756648b6bd6?s=8://s.gravatar.com/avatar/d4c74594d841139328695756648b6bd6?s=80",
      "project_id": 15,
      "project":{
        "id": 15,
        "name":"Diaspora",
        "description":"",
        "web_url":"http://example.com/mike/diaspora",
        "avatar_url":null,
        "git_ssh_url":"git@example.com:mike/diaspora.git",
        "git_http_url":"http://example.com/mike/diaspora.git",
        "namespace":"Mike",
        "visibility_level":0,
        "path_with_namespace":"mike/diaspora",
        "default_branch":"master",
        "homepage":"http://example.com/mike/diaspora",
        "url":"git@example.com:mike/diaspora.git",
        "ssh_url":"git@example.com:mike/diaspora.git",
        "http_url":"http://example.com/mike/diaspora.git"
      },
      "repository":{
        "name": "Diaspora",
        "url": "git@example.com:mike/diaspora.git",
        "description": "",
        "homepage": "http://example.com/mike/diaspora",
        "git_http_url":"http://example.com/mike/diaspora.git",
        "git_ssh_url":"git@example.com:mike/diaspora.git",
        "visibility_level":0
      },
      "commits": [
        {
          "id": "b6568db1bc1dcd7f8b4d5a946b0b91f9dacd7327",
          "message": "Update Catalan translation to e38cb41.",
          "timestamp": "2011-12-12T14:27:31+02:00",
          "url": "http://example.com/mike/diaspora/commit/b6568db1bc1dcd7f8b4d5a946b0b91f9dacd7327",
          "author": {
            "name": "Jordi Mallach",
            "email": "jordi@softcatala.org"
          },
          "added": ["CHANGELOG"],
          "modified": ["app/controller/application.rb"],
          "removed": []
        },
        {
          "id": "da1560886d4f094c3e6c9ef40349f7d38b5d27d7",
          "message": "fixed readme",
          "timestamp": "2012-01-03T23:36:29+02:00",
          "url": "http://example.com/mike/diaspora/commit/da1560886d4f094c3e6c9ef40349f7d38b5d27d7",
          "author": {
            "name": "GitLab dev user",
            "email": "gitlabdev@dv6700.(none)"
          },
          "added": ["CHANGELOG"],
          "modified": ["app/controller/application.rb"],
          "removed": []
        }
      ],
      "total_commits_count": 4
    },
    "headers": {
      "X-Gitlab-Event": ["Push Hook"],
      "X-Stargate-Request-Id": ["967d8788-9426-4c5c-9909-458f41177bbe"]
    },
  }
}

gitlab_merge_request(action) = event {
  event := {
    "payload": {
      "object_kind": "merge_request",
      "user": {
        "name": "Administrator",
        "username": "root",
        "avatar_url": "http://www.gravatar.com/avatar/e64c7d89f26bd1972efa854d13d7dd61?s=40\u0026d=identicon"
      },
      "project": {
        "id": 1,
        "name":"Gitlab Test",
        "description":"Aut reprehenderit ut est.",
        "web_url":"http://example.com/gitlabhq/gitlab-test",
        "avatar_url":null,
        "git_ssh_url":"git@example.com:gitlabhq/gitlab-test.git",
        "git_http_url":"http://example.com/gitlabhq/gitlab-test.git",
        "namespace":"GitlabHQ",
        "visibility_level":20,
        "path_with_namespace":"gitlabhq/gitlab-test",
        "default_branch":"master",
        "homepage":"http://example.com/gitlabhq/gitlab-test",
        "url":"http://example.com/gitlabhq/gitlab-test.git",
        "ssh_url":"git@example.com:gitlabhq/gitlab-test.git",
        "http_url":"http://example.com/gitlabhq/gitlab-test.git"
      },
      "repository": {
        "name": "Gitlab Test",
        "url": "http://example.com/gitlabhq/gitlab-test.git",
        "description": "Aut reprehenderit ut est.",
        "homepage": "http://example.com/gitlabhq/gitlab-test"
      },
      "object_attributes": {
        "id": 99,
        "target_branch": "master",
        "source_branch": "ms-viewport",
        "source_project_id": 14,
        "author_id": 51,
        "assignee_id": 6,
        "title": "MS-Viewport",
        "created_at": "2013-12-03T17:23:34Z",
        "updated_at": "2013-12-03T17:23:34Z",
        "milestone_id": null,
        "state": action,
        "merge_status": "unchecked",
        "target_project_id": 14,
        "iid": 1,
        "description": "",
        "source": {
          "name":"Awesome Project",
          "description":"Aut reprehenderit ut est.",
          "web_url":"http://example.com/awesome_space/awesome_project",
          "avatar_url":null,
          "git_ssh_url":"git@example.com:awesome_space/awesome_project.git",
          "git_http_url":"http://example.com/awesome_space/awesome_project.git",
          "namespace":"Awesome Space",
          "visibility_level":20,
          "path_with_namespace":"awesome_space/awesome_project",
          "default_branch":"master",
          "homepage":"http://example.com/awesome_space/awesome_project",
          "url":"http://example.com/awesome_space/awesome_project.git",
          "ssh_url":"git@example.com:awesome_space/awesome_project.git",
          "http_url":"http://example.com/awesome_space/awesome_project.git"
        },
        "target": {
          "name":"Awesome Project",
          "description":"Aut reprehenderit ut est.",
          "web_url":"http://example.com/awesome_space/awesome_project",
          "avatar_url":null,
          "git_ssh_url":"git@example.com:awesome_space/awesome_project.git",
          "git_http_url":"http://example.com/awesome_space/awesome_project.git",
          "namespace":"Awesome Space",
          "visibility_level":20,
          "path_with_namespace":"awesome_space/awesome_project",
          "default_branch":"master",
          "homepage":"http://example.com/awesome_space/awesome_project",
          "url":"http://example.com/awesome_space/awesome_project.git",
          "ssh_url":"git@example.com:awesome_space/awesome_project.git",
          "http_url":"http://example.com/awesome_space/awesome_project.git"
        },
        "last_commit": {
          "id": "da1560886d4f094c3e6c9ef40349f7d38b5d27d7",
          "message": "fixed readme",
          "timestamp": "2012-01-03T23:36:29+02:00",
          "url": "http://example.com/awesome_space/awesome_project/commits/da1560886d4f094c3e6c9ef40349f7d38b5d27d7",
          "author": {
            "name": "GitLab dev user",
            "email": "gitlabdev@dv6700.(none)"
          }
        },
        "work_in_progress": false,
        "url": "http://example.com/diaspora/merge_requests/1",
        "action": "open",
        "assignee": {
          "name": "User1",
          "username": "user1",
          "avatar_url": "http://www.gravatar.com/avatar/e64c7d89f26bd1972efa854d13d7dd61?s=40\u0026d=identicon"
        }
      },
      "labels": [{
        "id": 206,
        "title": "API",
        "color": "#ffffff",
        "project_id": 14,
        "created_at": "2013-12-03T17:15:43Z",
        "updated_at": "2013-12-03T17:15:43Z",
        "template": false,
        "description": "API related issues",
        "type": "ProjectLabel",
        "group_id": 41
      }],
      "changes": {
        "updated_by_id": {
          "previous": null,
          "current": 1
        },
        "updated_at": {
          "previous": "2017-09-15 16:50:55 UTC",
          "current":"2017-09-15 16:52:00 UTC"
        },
        "labels": {
          "previous": [{
            "id": 206,
            "title": "API",
            "color": "#ffffff",
            "project_id": 14,
            "created_at": "2013-12-03T17:15:43Z",
            "updated_at": "2013-12-03T17:15:43Z",
            "template": false,
            "description": "API related issues",
            "type": "ProjectLabel",
            "group_id": 41
          }],
          "current": [{
            "id": 205,
            "title": "Platform",
            "color": "#123123",
            "project_id": 14,
            "created_at": "2013-12-03T17:15:43Z",
            "updated_at": "2013-12-03T17:15:43Z",
            "template": false,
            "description": "Platform related issues",
            "type": "ProjectLabel",
            "group_id": 41
          }]
        }
      }
    },
    "headers": {
	  "X-Gitlab-Event": ["Merge Request Hook"],
      "X-Stargate-Request-Id": ["967d8788-9426-4c5c-9909-458f41177bbe"]
    }
  }
}
