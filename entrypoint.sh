#!/bin/bash

python tensorflow-2.3.0/tensorflow/examples/label_image/label_image.py \
  --labels="./imagenet_slim_labels.txt" \
  --graph="./inception_v3_2016_08_28_frozen.pb" \
  --image="$1"
