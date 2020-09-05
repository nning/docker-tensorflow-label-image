# tensorflow-label-image

This is a basic docker image that uses the tensorflow label_image example with
the Inception v3 model for image classification.

## Basic Usage

    docker run --rm -v $(pwd)/example.jpg:/tmp/example.jpg nning2/label_image /tmp/example.jpg
