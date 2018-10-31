FROM alpine:latest
MAINTAINER Sébastien Prud'homme <sebastien.prudhomme@gmail.com>

ENV KUBERNETES_VERSION 1.12.0
ENV HELM_VERSION 2.11.0

RUN apk add -U openssl curl tar gzip bash ca-certificates git && \
    curl -L -o /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    curl -L -O https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk && \
    apk add glibc-2.28-r0.apk && \
    rm glibc-2.28-r0.apk

RUN curl -O "https://kubernetes-helm.storage.googleapis.com/helm-v${HELM_VERSION}-linux-amd64.tar.gz" && \
    tar zxf helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    rm helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/bin/ && \
    mv linux-amd64/tiller /usr/bin/ && \
    helm version --client && \
    tiller -version

RUN curl -L -o /usr/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl" && \
    chmod +x /usr/bin/kubectl && \
    kubectl version --client
    
