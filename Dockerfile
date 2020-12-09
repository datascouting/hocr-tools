#
# Build: docker build -t hocr-tools .
# Start: docker run -it --rm hocr-tools
#

FROM ubuntu:20.04 as production
MAINTAINER "Iordanis Kostelidis <ikostelidis@datascouting.com>"

ENV PYTHONIOENCODING utf8

RUN apt-get update \
 && apt-get install -y \
    apt-utils \
 && apt-get install -y \
    pdfgrep \
    python3 \
    python3-tk \
    python3-dev \
    python3-pip \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /usr/src/app

RUN python setup.py install

CMD ["bash"]
