# Building Go-based Operators using operator-SDK 

Project creating commands are:
```
operator-sdk init --domain example.com --repo github.com/example/memcached-operator
operator-sdk create api --group cache --version v1alpha1 --kind Memcached --resource --controller
```

To run your operator in a local development cluster. 
```
make install run
```

This project will:

* Create a Memcached Deployment if it doesn’t exist
* Ensure that the Deployment size is the same as specified by the Memcached CR spec
* Update the Memcached CR status using the status writer with the names of the CR’s pods
