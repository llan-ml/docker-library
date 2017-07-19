#!/bin/bash

docker_server="gcr.io/google_containers/"
K8S_VERSION="v1.6.0"
DNS_VERSION="1.14.1"
ETCD_VERSION="3.0.17"
ARCH="amd64"
docker_image_names="\
kube-apiserver-${ARCH}:${K8S_VERSION} \
kube-controller-manager-${ARCH}:${K8S_VERSION} \
kube-scheduler-${ARCH}:${K8S_VERSION} \
kube-proxy-${ARCH}:${K8S_VERSION} \
etcd-${ARCH}:${ETCD_VERSION} \
pause-${ARCH}:3.0 \
k8s-dns-sidecar-${ARCH}:${DNS_VERSION} \
k8s-dns-kube-dns-${ARCH}:${DNS_VERSION} \
k8s-dns-dnsmasq-nanny-${ARCH}:${DNS_VERSION}"

for image in ${docker_image_names}
do
  basename=$(echo $image | awk -F: '{printf $1}')
  mkdir -p ${basename}
  pushd ${basename}
  echo -e "FROM ${docker_server}${image}\nMAINTAINER Lin Lan" > Dockerfile
  popd
done

FLANNEL_VERSION="v0.8.0-amd64"
flannel_image_name="\
quay.io/coreos/flannel:${FLANNEL_VERSION}"
mkdir -p flannel
pushd flannel
echo -e "FROM ${flannel_image_name}\nMAINTAINER Lin Lan" > Dockerfile
popd

