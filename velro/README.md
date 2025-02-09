commands to running using minio and minikube.

Start a local cluster :

```
minikube start
```

 Create a Velero-specific credentials file (credentials-velero)

```
echo "[default]
aws_access_key_id = minio
aws_secret_access_key = minio123" > credentials-velero
```

After starting the minio service install veleero, 
```
velero install     --provider aws     --plugins velero/velero-plugin-for-aws:v1.2.1     
--bucket velero     --secret-file ./credentials-velero     --use-volume-snapshots=false     
--backup-location-config region=minio,s3ForcePathStyle="true",s3Url=http://minio.velero.svc:9000
```

To create a backup run:
```
velero backup create [backup_name] --include-namespaces [list of namespaces to include]
```

Note: delete the namespace that you have backedup to simulate a disaster. 

To start a restore run:
```
velero restore create --from-backup [backup_name]
```

