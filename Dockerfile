FROM python:3.8-slim

ARG AIRFLOW_HOME=/opt/airflow
ENV DEBIAN_FRONTEND noninteractive

WORKDIR ${AIRFLOW_HOME}

RUN useradd -s /bin/bash -d ${AIRFLOW_HOME} airflow

RUN apt update && \
    apt install -y curl dnsutils build-essential && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir \
    apache-airflow[kubernetes,postgres]==1.10.12 \
    airflow-exporter \
    dask[complete]==2.30.0 \
    distributed==2.30.0

COPY dags dags

RUN chown -R airflow ${AIRFLOW_HOME}

USER airflow
