# Engines in Cloudera Machine Learning
This directory contains an example Dockerfile for building a customized engine image for CML.

To begin, download the Dockerfile, open a terminal window, and change into the directory containing the Dockerfile. To build and tag the image, run the command
```shell
docker build -t user/repo:x . -f Dockerfile
```
where `user` is your Docker Hub username, `repo` is the name of a Docker Hub repository, and `x` is a tag. After the image finishes building, run
```shell
docker push user/repo:x
```
to push the image to Docker Hub. If you are using an image registry other than Docker Hub, you must qualify the repository name with a hostname in both commands. 

For more information, see the [Engines section of the CML documentation](https://docs.cloudera.com/machine-learning/cloud/engines/index.html).
