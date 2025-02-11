#!/bin/bash

kubectl apply -f ./examples/nginx-app.yaml

kubectl get ns

velero install     --provider aws     --plugins velero/velero-plugin-for-aws:v1.11.0     --bucket velero-bucket     --backup-location-config region=us-east-1     --snapshot-location-config region=us-east-1     --secret-file credentials-velero 

kubectl get ns

velero get backup-locations 

velero backup create v1 --include-namespaces nginx-example

kubectl delete ns nginx-example

velero restore create --from-backup v1

velero delete backup v1

