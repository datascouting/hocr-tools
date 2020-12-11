#
# Build: docker build -t hocr-tools .
# Start: docker run -it --rm hocr-tools
#

FROM ubuntu:20.04 as production
MAINTAINER "Iordanis Kostelidis <ikostelidis@datascouting.com>"

ENV DEBIAN_FRONTEND="noninteractive"
ENV PYTHONIOENCODING utf8

RUN apt-get update \
 && apt-get install -y \
    apt-utils \
 && apt-get install -y \
    software-properties-common \
 && add-apt-repository -y ppa:deadsnakes/ppa \
 && apt-get update \
 && apt-get install -y \
    python3.6 \
    python3.6-tk \
    python3.6-dev \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
 && apt-get remove -y python3.8 \
 && apt-get install -y python3-pip \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
 && apt-get install -y \
    pdfgrep \
    libjpeg8-dev \
    git \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . /usr/src/app

RUN python3.6 setup.py install

CMD ["bash"]
