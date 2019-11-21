#!/usr/bin/env bash

set -e

helm template . | kapp deploy -a ci-stage2 -y -f -
