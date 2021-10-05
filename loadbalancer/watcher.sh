#!/bin/bash
set -x

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl

while true
do
    ./kubectl get svc --namespace $NAMESPACE $SERVICE | grep pending
    if [ ! $? -eq 0 ]; then
    break
    fi

    sleep 1
done

IP=$(./kubectl get svc --namespace $NAMESPACE $SERVICE --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")

PATCH=`printf '{"data":{"%s": "%s"}}' $CONFIG_MAP_KEY $IP`
./kubectl patch --namespace $NAMESPACE configmap $CONFIG_MAP --type=merge -p "${PATCH}"

[[ ! -z "$IP" ]] && exit 0
