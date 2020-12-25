#!/bin/bash

# More infos https://github.com/bitnami-labs/sealed-secrets/blob/master/docs/bring-your-own-certificates.md

export PRIVATEKEY="mytls.key"
export PUBLICKEY="mytls.crt"
export NAMESPACE="buttahtoast-system"
export SECRETNAME="mycustomkeys"

[ ! -f ./${PRIVATEKEY}] && echo Private does not exists && exit1
[ ! -f ./${PUBLICKEY}] && echo Public does not exists && exit1

kubectl -n "$NAMESPACE" create secret tls "$SECRETNAME" --cert="$PUBLICKEY" --key="$PRIVATEKEY"
kubectl -n "$NAMESPACE" label secret "$SECRETNAME" sealedsecrets.bitnami.com/sealed-secrets-key=active

kubectl -n  "$NAMESPACE" delete pod -l app.kubernetes.io/name=sealed-secrets
