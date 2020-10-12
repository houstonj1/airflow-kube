FROM python:3.8

WORKDIR /opt/airflow

RUN pip install apache-airflow[kubernetes,postgres]==1.10.12
