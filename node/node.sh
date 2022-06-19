#!/bin/bash

accessKey="token-hxvn7"
secretKey="dqkk8g4slb42rf9pd8sf5hdw8gl9jvdwgt9vkrc6pg4czmn29k7r9z"
endPoint="https://aps1-rancher.tplinknbu.com/v3/nodes"

# curl -k -u "${accessKey}:${secretKey}" ${endPoint} > node.status

clusters=("prd-nbu-aps1" "prd-nbu-euw1" "prd-nbu-use1")

for cluster in ${clusters[@]}
do
cat node.status | jq '.data[] | select(.labels."alpha.eksctl.io/cluster-name" == "'$cluster'") | 
[
.labels."alpha.eksctl.io/cluster-name",
.labels."alpha.eksctl.io/nodegroup-name",
.labels."kubernetes.io/hostname",
.allocatable.cpu,
.allocatable.memory,
.requested.cpu,
.requested.memory
] | @csv
' > ${cluster}.csv
done