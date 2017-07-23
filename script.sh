#!/bin/bash

set -e

gcr_prefix="gcr.io/google_containers/"
K8S_VERSION="v1.6.0"
PAUSE_VERSION="3.0"
DNS_VERSION="1.14.4"
ETCD_VERSION="3.0.17"
FLANNEL_VERSION="v0.8.0-amd64"
DASHBOARD_VERSION="v1.6.1"
HEAPSTER_VERSION="v1.3.0"
ARCH="amd64"

docker_image_names="\
${gcr_prefix}kube-apiserver-${ARCH}:${K8S_VERSION} \
${gcr_prefix}kube-controller-manager-${ARCH}:${K8S_VERSION} \
${gcr_prefix}kube-scheduler-${ARCH}:${K8S_VERSION} \
${gcr_prefix}kube-proxy-${ARCH}:${K8S_VERSION} \
${gcr_prefix}pause-${ARCH}:${PAUSE_VERSION} \
${gcr_prefix}etcd-${ARCH}:${ETCD_VERSION} \
${gcr_prefix}k8s-dns-sidecar-${ARCH}:${DNS_VERSION} \
${gcr_prefix}k8s-dns-kube-dns-${ARCH}:${DNS_VERSION} \
${gcr_prefix}k8s-dns-dnsmasq-nanny-${ARCH}:${DNS_VERSION} \
${gcr_prefix}kubernetes-dashboard-${ARCH}:${DASHBOARD_VERSION} \
${gcr_prefix}heapster-${ARCH}:${HEAPSTER_VERSION} \
quay.io/coreos/flannel:${FLANNEL_VERSION}"

for image in ${docker_image_names}
do
  registry=$(echo $image | awk -F/ '{printf $1}')
  namespace=$(echo $image | awk -F/ '{printf $2}')
  base=$(echo $image | awk -F/ '{printf $3}' | awk -F: '{printf $1}')
  tag=$(echo $image | awk -F/ '{printf $3}' | awk -F: '{printf $2}')
  mkdir -p ${base}
  pushd ${base}
  echo -e "FROM ${image}\nMAINTAINER Lin Lan" > Dockerfile
  popd
done

