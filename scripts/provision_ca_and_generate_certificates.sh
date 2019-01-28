#!/usr/bin/env bash

KUBERNETES_PUBLIC_ADDRESS=192.168.33.30
# Generate CA Key and Certificate
cfssl gencert -initca config/ca-csr.json | cfssljson -bare ca

# Generate Admin Client Certificate
 cfssl gencert \
   -ca=ca.pem \
   -ca-key=ca-key.pem \
   -config=config/ca-config.json \
   -profile=kubernetes \
   config/admin-csr.json | cfssljson -bare admin

# Kubelet Client Certificates
 cfssl gencert \
   -ca=ca.pem \
   -ca-key=ca-key.pem \
   -config=config/ca-config.json \
   -hostname=w1,192.168.33.21 \
   -profile=kubernetes \
   config/w1-csr.json | cfssljson -bare w1

 cfssl gencert \
   -ca=ca.pem \
   -ca-key=ca-key.pem \
   -config=config/ca-config.json \
   -hostname=w2,192.168.33.22 \
   -profile=kubernetes \
   config/w2-csr.json | cfssljson -bare w2

# Controller Manager Client Certificate
 cfssl gencert \
   -ca=ca.pem \
   -ca-key=ca-key.pem \
   -config=config/ca-config.json \
   -profile=kubernetes \
   config/kube-controller-manager-csr.json | cfssljson -bare kube-controller-manager


# Kube Proxy Client Certificate
 cfssl gencert \
   -ca=ca.pem \
   -ca-key=ca-key.pem \
   -config=config/ca-config.json \
   -profile=kubernetes \
   config/kube-proxy-csr.json | cfssljson -bare kube-proxy

# Scheduler Client Certificate
 cfssl gencert \
   -ca=ca.pem \
   -ca-key=ca-key.pem \
   -config=config/ca-config.json \
   -profile=kubernetes \
   config/kube-scheduler-csr.json | cfssljson -bare kube-scheduler

# Kubernetes API Server Certificate
 cfssl gencert \
   -ca=ca.pem \
   -ca-key=ca-key.pem \
   -config=config/ca-config.json \
   -hostname=10.32.0.1,192.168.33.11,192.168.33.12,${KUBERNETES_PUBLIC_ADDRESS},127.0.0.1,kubernetes.default \
   -profile=kubernetes \
   config/kubernetes-csr.json | cfssljson -bare kubernetes

# Service Account Key Pair
 cfssl gencert \
   -ca=ca.pem \
   -ca-key=ca-key.pem \
   -config=config/ca-config.json \
   -profile=kubernetes \
   config/service-account-csr.json | cfssljson -bare service-account