Create a new project:
```
kubebuilder init --domain stable.example.com --repo stable.example.com/v1
```
Create a new API:
```
kubebuilder create api --group stable --version v1 --kind PdfDocument
```

After editing the API definitions, generate the manifests:
```
make manifests
```

Install the CRDs into the cluster:
```
make install
```

Run your controller locally:
```
make run
```
To run your controller on cluster:
Build and push your image 
```
make docker-build docker-push IMG=<some-registry>/<project-name>:tag
```

```
make deploy IMG=<some-registry>/<project-name>:tag
```