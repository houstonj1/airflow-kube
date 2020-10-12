# Airflow kube

All things airflow + kube

Airflow on Kube  
Airflow with KubeExecutor  
Airflow DAGS with KubeOperator

## Local Setup

- KIND
- Helm
- postgresql-client

### Kube
```bash
kind create cluster
```

### Postgres

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
