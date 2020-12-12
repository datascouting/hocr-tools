#
# Build: docker build -t hocr-tools .
# Start: docker run -it --rm hocr-tools
#

FROM python:3.6.12-stretch
MAINTAINER "Iordanis Kostelidis <ikostelidis@datascouting.com>"

ENV DEBIAN_FRONTEND="noninteractive"
ENV PYTHONIOENCODING utf8

RUN apt-get update \
 && apt-get install -y \
    apt-utils \
 && apt-get install -y \
    pdfgrep \
    git \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . /usr/src/app

RUN python3.6 setup.py install

CMD ["bash"]
