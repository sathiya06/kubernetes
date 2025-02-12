# Steps to backup and restore a demo application using velero

Start a local cluster with minikube:

```
minikube start
```

> [!NOTE]
> If you are gonna use AWS as storage provider run the `aws-storage-location-setup` script to create access key and s3 bucket.

 Create a Velero-specific credentials file (credentials-velero)

```
echo "[default]
aws_access_key_id = minio
aws_secret_access_key = minio123" > credentials-velero
```

Note: For backing up volumes add --use-node-agent 

After starting the minio service install veleero, 
```
velero install     --provider aws     --plugins velero/velero-plugin-for-aws:v1.2.1     
--bucket velero     --secret-file ./credentials-velero     --use-volume-snapshots=false     
--backup-location-config region=minio,s3ForcePathStyle="true",s3Url=http://minio.velero.svc:9000
```


If you are using AWS as storage run:
```
velero install     --provider aws     --plugins velero/velero-plugin-for-aws:v1.11.0     --bucket [bucket-name]    --backup-location-config region=[REGION]     --snapshot-location-config region=[REGION]    --secret-file credentials-aws 
```

Run a Nginx deployment:
```
kubectl create -f examples/nginx-app.yaml 
```

To create a backup run:
```
velero backup create [backup_name] --include-namespaces [list of namespaces to include]
```
> [!NOTE]
> Update your backup storage location to read-only mode:
```
kubectl patch backupstoragelocation [STORAGE LOCATION NAME] \
    --namespace velero \
    --type merge \
    --patch '{"spec":{"accessMode":"ReadOnly"}}'
```


To start a restore run:
```
velero restore create --from-backup [backup_name]
```
Update your backup storage location to read-write mode
```
kubectl patch backupstoragelocation <STORAGE LOCATION NAME> \
   --namespace velero \
   --type merge \
   --patch '{"spec":{"accessMode":"ReadWrite"}}'
```

cleanup
```
velero delete backups --all
velero delete backup-locations --all
kubectl delete ns nginx-example
```