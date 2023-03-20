# Set the base image to Ubuntu 20.04 and NVIDIA GPU
FROM nvidia/cuda:11.7.1-cudnn8-runtime-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update  && \
    apt install --yes wget lsb-release && \
    export PLATFORM=$(lsb_release -cs) && \
    wget -O- https://cdn.oxfordnanoportal.com/apt/ont-repo.pub | apt-key add -  && \
    echo "deb http://cdn.oxfordnanoportal.com/apt ${PLATFORM}-stable non-free" | tee /etc/apt/sources.list.d/nanoporetech.sources.list  && \
    apt update

RUN apt-get update  && \
    apt-get install --no-install-recommends --yes ont-guppy

RUN apt update  && \
    apt install --yes unzip

RUN rm -rf /usr/lib/x86_64-linux-gnu/libnvidia* /usr/lib/x86_64-linux-gnu/libcuda*

COPY scripts /app/