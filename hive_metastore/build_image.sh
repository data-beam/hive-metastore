#!/bin/bash

set -e

REPONAME=ghcr.io/data-beam/hive-metastore
TAG=latest

docker build -t $REPONAME:$TAG .

# Tag and push to the public docker repository.
# docker tag $TAG $REPONAME:$TAG
docker push $REPONAME:$TAG


# Update configmaps
kubectl create ns hive
kubens hive
kubectl create configmap metastore-cfg --dry-run --from-file=metastore-site.xml --from-file=core-site.xml -o yaml | kubectl apply -f -
