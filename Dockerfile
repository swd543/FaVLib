FROM jupyter/pyspark-notebook
USER root

WORKDIR /juypter
COPY . ./

RUN chown -R jovyan /juypter && \
    chmod -R 777 ./

RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    build-essential \
    curl

RUN pip install --upgrade pip && \
  pip3 install -r requirements.txt


RUN conda install -c bioconda cwltool