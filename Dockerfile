# docker build -t tensorflow-label-image .

FROM ubuntu:20.04

RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y \
  curl \
  python3 \
  python3-pip

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10

RUN pip3 install tensorflow

RUN mkdir -p /opt/label_image
WORKDIR /opt/label_image

ADD entrypoint.sh .
ADD compat-v1.patch .

RUN curl -L https://github.com/tensorflow/tensorflow/archive/v2.3.0.tar.gz | tar xzf -
RUN cd tensorflow-2.3.0 && patch -p1 < ../compat-v1.patch

RUN curl -L https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz | tar xzf -

ENTRYPOINT ["bash", "entrypoint.sh"]
