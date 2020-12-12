#
# Build: docker build -t hocr-tools .
# Start: docker run -it --rm hocr-tools
#

FROM ubuntu:18.04
MAINTAINER "Iordanis Kostelidis <ikostelidis@datascouting.com>"

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update \
 && apt-get install -y \
    apt-utils \
 && apt-get install -y \
    locales \
    locales-all \
 && rm -rf /var/lib/apt/lists/*

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
RUN apt-get update \
 && apt-get install -y \
    git \
    libjpeg8-dev \
    nano \
    python3 \
    python3-tk \
    python3-pip \
    pdfgrep \
    wget \
    zlib1g-dev \
 && rm -rf /var/lib/apt/lists/* \
 && rm -f /usr/bin/python \
 && ln -s /usr/bin/python3 /usr/bin/python


ENV PYTHONIOENCODING utf8
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . /usr/src/app

RUN python3 setup.py install

CMD ["bash"]
