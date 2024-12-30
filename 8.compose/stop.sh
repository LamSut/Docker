#!/bin/bash

# change Docker daemon to Minikube
eval $(minikube docker-env)

# remove port forwarding
pkill -f "kubectl port-forward"

# delete Minikube deployments
minikube kubectl -- delete deployment backend
minikube kubectl -- delete deployment frontend

# delete Minikube StatefulSets
minikube kubectl -- delete statefulsets mysql
minikube kubectl -- delete statefulsets redis

# delete Minikube services
minikube kubectl -- delete service frontend
minikube kubectl -- delete service backend
minikube kubectl -- delete service mysql
minikube kubectl -- delete service redis

# (WARNING: Those actions below will permanently delete data)

# # delete Minikube PersistentVolumeClaims
# minikube kubectl -- delete pvc shared-pvc shared-storage-mysql-0 shared-storage-mysql-1

# # remove Docker images
# docker image rm -f frontend:v1 backend:v1 mysql:8.0

# remove repository
rm -rf repo

echo "Minikube resources deleted successfully!"