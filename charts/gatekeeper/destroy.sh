#!/usr/bin/env bash

set -e

echo "This is not working yet since gatekeeper doesn't remove all of finalizers. So, resources can not be removed and you will need to remove the finalizer by editing all resources that are in terminating state"

echo kapp delete -a gatekeeper
