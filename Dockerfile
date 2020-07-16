FROM ubuntu:latest
MAINTAINER steer629

ENV PATH /usr/local/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

RUN apt-get update \
    && apt-get install software-properties-common -y\
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get install -y python3.7 gunicorn python3-pip python3-psycopg2 mdbtools nginx\    
    python3-dev vim default-libmysqlclient-dev curl sudo g++ unzip libaio-dev wget\
#add for remote vs
    && apt-get install -y git iproute2 procps lsb-release apt-utils dialog 2>&1 \
#clean up 
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
    
RUN echo "alias python=python3" >> ~/.bashrc \
    &&  alias python=pythonn

COPY requirement.txt .

# Install our requirements.
RUN pip3 install -Ur requirement.txt
