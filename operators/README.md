# Building Go-based Operators using operator-SDK 

Project creating commands are:
```
operator-sdk init --domain example.com --repo github.com/example/memcached-operator
operator-sdk create api --group cache --version v1alpha1 --kind Memcached --resource --controller
```
Make the required changes to the below files based on the functions that you need the operator todo
+ `api/v1alpha1/[operator_name]_types.go` - Define the different values need for you CR.
+ `internal/controller/[operator_name]_controller.go` - complete the reconcile loop for your controller.

Run the below command to generate manifest:
```
make manifests
```

Install the CRDs into the cluster:
```
make install
```

To run your operator in the cluster. 
```
make run
```

