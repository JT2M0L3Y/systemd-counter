# get golang from official image
FROM golang:latest as go-src

# set ubuntu base image
FROM ubuntu:latest

# set working directory
WORKDIR /app

# copy files
COPY . .

# install dependencies
RUN apt-get update && apt-get install -y make
COPY --from=go-src /usr/local/go /usr/local/go

# set go path
ENV PATH=$PATH:/usr/local/go/bin

# run application
CMD ["make", "build-deb"]
