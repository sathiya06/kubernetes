#!/bin/bash


# Normal backup without enabling --use-node-agent for backing up volumes --features=EnableCSI
minikube delete
minikube start

minikube addons enable volumesnapshots
minikube addons enable csi-hostpath-driver

kubectl patch storageclass csi-hostpath-sc -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

kubectl api-resources | grep persistent



kubectl apply -f nginx-with-pv.yaml

kubectl get ns

velero install     --provider aws     --plugins velero/velero-plugin-for-aws:v1.11.0     --bucket velero-backu     --backup-location-config region=us-east-1     --snapshot-location-config region=us-east-1     --secret-file ../../../../velero/credentials-aws 

kubectl get ns

velero get backup-locations 

# --default-volumes-to-fs-backup 
#for opt-out approach of volume backups

velero backup create v1 --include-namespaces nginx-example



velero restore create --from-backup v1

# when we run the below command it prints that it has deleted the backups associated with the backup - location but it still exists in aws
# velero delete backup-locations --all


# get the pod name using nginx-logs
kubectl get pods -n nginx-example -o jsonpath="{.items[?(@.spec.volumes[*].persistentVolumeClaim.claimName=='nginx-logs')].metadata.name}"

kubectl -n nginx-example annotate pod/[pod-name] backup.velero.io/backup-volumes=nginx-logs

# test pv
kubectl get pods -n nginx-example
kubectl exec -it [pod_name] -n nginx-example -c fsfreeze -- /bin/bash

cd var/log/nginx/
echo "hello from test.txt" > test.txt
ls
exit