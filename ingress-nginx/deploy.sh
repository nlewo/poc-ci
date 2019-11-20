#!/bin/bash

kapp deploy -a ingress-nginx -y -f deployment

PUB_IP=$(kubectl get svc -n ingress-nginx ingress-nginx -o json | \
         jq -er .status.loadBalancer.ingress[].ip)

echo "Ingress available on ${PUB_IP}."

cat <<EOF > ../stargate/values-ingress.yaml
ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: nginx
  hosts:
    - host: stargate-${PUB_IP}.nip.io
      paths:
        - /webhooks
EOF

echo "Generated ingress for stargate at ../stargate/values-ingress.yaml"
