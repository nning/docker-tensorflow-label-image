FROM base/archlinux:latest

RUN mkdir /opt/label_image

WORKDIR /opt/label_image
RUN curl -L "https://storage.googleapis.com/download.tensorflow.org/models/inception_v3_2016_08_28_frozen.pb.tar.gz" | tar xzf -
ADD label_image.sh .
RUN chmod 700 label_image.sh

RUN pacman -Sy --noconfirm bazel unzip base-devel python
RUN curl -L https://github.com/tensorflow/tensorflow/archive/master.zip > master.zip
RUN unzip master.zip

WORKDIR tensorflow-master
RUN sed -i s:-lm:-static:g tensorflow/examples/label_image/BUILD
RUN PYTHON_BIN_PATH=/usr/sbin/python PYTHON_LIB_PATH=/usr/lib/python3.6/site-packages TF_NEED_MKL=0 CC_OPT_FLAGS="-march=native" TF_NEED_JEMALLOC=1 TF_NEED_GCP=0 TF_NEED_HDFS=0 TF_ENABLE_XLA=0 TF_NEED_VERBS=0 TF_NEED_OPENCL=0 TF_NEED_CUDA=0 TF_NEED_MPI=0 ./configure
RUN bazel build tensorflow/examples/label_image/...

WORKDIR /opt/label_image
