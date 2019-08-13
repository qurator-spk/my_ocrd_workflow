FROM ubuntu:18.04

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8

RUN apt-get update && \
    apt-get install -y \
      git \
      libleptonica-dev \
      libtesseract-dev \
      libxml2-utils \
      python3-pip \
      tesseract-ocr-all \
      xmlstarlet \
    && \
    apt-get clean

COPY requirements.txt /tmp
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt

COPY my_ocrd_workflow /usr/bin
COPY xsd              /usr/bin/xsd

# XXX Hack
COPY ../experiments/ocr-eval /usr/local/ocr-eval
RUN pip3 install --no-cache-dir -r /usr/local/ocr-eval/requirements.txt


WORKDIR /data
CMD ["/usr/bin/my_ocrd_workflow"]
