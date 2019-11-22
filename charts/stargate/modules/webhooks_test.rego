package webhooks

test_github_push_master_event {
  rs = resources with input as github_push("master")
  rs[_][_].spec.taskRef.name = "ci-stage2"
}

test_gitlab_push_master_event {
  ts = resources with input as gitlab_push("master")
  ts[_][_].spec.taskRef.name = "ci-stage2"
}

test_github_push_non_master_event {
  ts = resources with input as github_push("foo")
	count(ts) == 0
}

test_gitlab_push_non_master_event {
  ts = resources with input as gitlab_push("foo")
	count(ts) == 0
}

test_github_pull_request_opened_event {
	ts = resources with input as github_pull_request("opened")
	ts[_][_].spec.taskRef.name = "ci-stage2"
}

test_gitlab_merge_request_opened_event {
	ts = resources with input as gitlab_merge_request("opened")
	ts[_][_].spec.taskRef.name = "ci-stage2"
}

test_github_pull_request_synchronize_event {
	ts = resources with input as github_pull_request("synchronize")
	ts[_][_].spec.taskRef.name = "ci-stage2"
}

test_gitlab_merge_request_updated_event {
	ts = resources with input as gitlab_merge_request("updated")
	ts[_][_].spec.taskRef.name = "ci-stage2"
}

test_github_pull_request_non_managed_event {
	ts = resources with input as github_pull_request("review_request_removed")
	count(ts) == 0
}

test_broken_event {
	not event with input as {
		"payload": {},
		"headers": {
			"X-X-X": "foo"
		}
	}
}
