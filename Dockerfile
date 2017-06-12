FROM base/archlinux:latest

RUN mkdir /opt/label_image

WORKDIR /opt/label_image
RUN curl -L "https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz" | tar xzf -
ADD label_image.sh

RUN pacman -Sy --noconfirm bazel unzip base-devel
RUN curl -L https://github.com/tensorflow/tensorflow/archive/master.zip > master.zip
RUN unzip master.zip

WORKDIR tensorflow-master
RUN sed -i s:-lm:-static:g tensorflow/examples/label_image/BUILD
RUN bazel build tensorflow/examples/label_image/...

WORKDIR /opt/label_image
