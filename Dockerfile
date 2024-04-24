# set ubuntu base image
FROM ubuntu:latest

# arguments
# ARG GOLANG_VERSION=1.18.0

# set working directory
WORKDIR /app

# copy files
COPY . .

# install project dependencies
RUN apt-get update && apt-get install -y make golang
# RUN apt-get install -y make
# RUN apt-get install -y wget

# # download go
# RUN rm -rf /usr/local/go ../go
# RUN wget https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz

# # extract go, set path
# RUN tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz
# ENV PATH=$PATH:/usr/local/go/bin

# cleanup
# RUN rm go1.22.*

# run golang binary
CMD ["make", "run"]
