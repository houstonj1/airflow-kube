# Airflow kube

All things airflow + kube

Airflow on Kube  
Airflow with KubeExecutor  
Airflow Dags with KubeOperator

## Local Setup

- Docker
- Kind
- Helm
- postgresql-client

Steps to get up and running:
1. Start kind cluster
2. Install Postgresql
3. Run the [init.sql](sql/init.sql) script against postgresql
4. Kubectl apply k8s yaml

### Kube
```bash
kind create cluster
```

### Postgres

Documentation on this helm chart can be found [here](https://github.com/bitnami/charts/tree/master/bitnami/postgresql#postgresql)

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install postgres bitnami/postgresql

kubectl port-forward --namespace default svc/postgres-postgresql 5432:5432 &

export PGPASSWORD=$(kubectl get secret --namespace default postgres-postgresql -o jsonpath="{.data.postgresql-password}" | base64 --decode)
```

```bash
# Create the airflow databse
psql -h localhost -U postgres -f sql/init.sql

# Drop the airflow database
psql -h localhost -U postgres -f sql/drop.sql
```

### Dockerfile

[This](Dockerfile) Dockerfile for airflow is pushed [here](https://hub.docker.com/r/houstonj1/airflow).

The kubernetes manifests in this example use this Docker image.

### Kubernetes

This example uses Kustomize to deploy to a local / remote Kubernetes cluster

```bash
kubectl apply -k k8s/

# Connecting to Airflow
kubectl port-forward --namespace default svc/airflow-webserver 3000:80 &
```
### Dask ( Optional )

Documentation for this helm chart can be found [here](https://docs.dask.org/en/latest/setup/kubernetes-helm.html)

```bash
helm repo add dask https://helm.dask.org/
helm repo update

helm install dask dask/dask

# Connecting to Dask
kubectl port-forward --namespace default svc/dask-scheduler 3001:8786 &
kubectl port-forward --namespace default svc/dask-scheduler 3002:80 &
```
