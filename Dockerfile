FROM python:3.8-slim

ARG AIRFLOW_HOME=/opt/airflow
ENV DEBIAN_FRONTEND noninteractive

WORKDIR ${AIRFLOW_HOME}

RUN useradd -s /bin/bash -d ${AIRFLOW_HOME} airflow && \
    chown -R airflow ${AIRFLOW_HOME}

RUN apt update && \
    apt install -y build-essential

RUN pip install --upgrade pip
RUN pip install apache-airflow[kubernetes,postgres]==1.10.12

USER airflow
