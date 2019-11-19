#!/usr/bin/env bash

set -e

helm template --values=values.yaml  .  --set withGatekeeperConstraintsCRDs=false | kapp deploy -a gatekeeper -y -f -

echo "Waiting for cirules.constraints.gatekeeper.sh crd creation"
while ! kubectl get crd cirules.constraints.gatekeeper.sh;
do
    sleep 1
done

helm template --values=values.yaml  . | kapp deploy -a gatekeeper -y -f -
