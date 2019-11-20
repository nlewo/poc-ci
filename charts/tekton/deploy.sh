#!/usr/bin/env bash

set -e

helm template --values=values.yaml . | kapp deploy -a tekton -y -f -
