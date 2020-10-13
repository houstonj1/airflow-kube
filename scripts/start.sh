#!/bin/bash
set -euo pipefail

declare -A DEPENDENCIES

DEPENDENCIES=( 
    ["docker"]="https://docs.docker.com/get-docker/" 
    ["kind"]="https://kind.sigs.k8s.io/docs/user/quick-start/" 
    ["kubectl"]="https://kubernetes.io/docs/tasks/tools/install-kubectl/" 
    ["helm"]="https://helm.sh/docs/intro/install/"
)
FAILED=0

check() {
    IS_INSTALLED=$(which ${1} 2>/dev/null || echo FALSE)
    if [ $IS_INSTALLED = "FALSE" ]
    then
        echo -e "\n\t*** ${1} is not installed ***"
        echo -e "Visit: ${2}\n"
        FAILED=1
    fi
}

main() {
    for DEP in "${!DEPENDENCIES[@]}"
    do 
        check $DEP "${DEPENDENCIES[$DEP]}"
    done

    if [ $FAILED -gt 0 ]
    then
        exit 1
    fi
}

main
# helm repo add bitnami https://charts.bitnami.com/bitnami
# helm repo update
# helm install postgres bitnami/postgresql

# kubectl port-forward --namespace default svc/postgres-postgresql 5432:5432 &

# export PGPASSWORD=$(kubectl get secret --namespace default postgres-postgresql -o jsonpath="{.data.postgresql-password}" | base64 --decode)
