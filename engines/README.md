# Engines in Cloudera Machine Learning
This directory contains an example Dockerfile for building a customized engine image for CML.

To begin, download the Dockerfile, keeping its filename as `Dockerfile` with no file extension. Open a terminal window and change into the directory containing `Dockerfile`. To build and tag the image, run the command
```shell
docker build -t user/repo:tag .
```
where `user` is a Docker Hub username or organization name, `repo` is the name of a Docker Hub repository owned by that user or organization, and `tag` is a number or string uniquely identifying the image in the repository. After the image finishes building, run
```shell
docker push user/repo:tag
```
to push the image to Docker Hub. If you are using an image registry other than Docker Hub, you must qualify `user` with a repository path in both commands. 

For more information, see the [Engines section of the CML documentation](https://docs.cloudera.com/machine-learning/cloud/engines/index.html).
