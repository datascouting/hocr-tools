#
# Build: docker build -t hocr-tools-app .
# Start: docker run -it --rm hocr-tools-app
#

FROM python:3.6-buster
MAINTAINER "Iordanis Kostelidis <ikostelidis@datascouting.com>"

ENV PYTHONIOENCODING utf8

RUN apt-get update \
  && apt-get install -y --no-install-recommends pdfgrep \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

COPY . /usr/src/app

RUN python setup.py install

CMD ["bash"]
