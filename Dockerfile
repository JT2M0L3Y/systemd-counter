# set ubuntu base image
FROM ubuntu:latest

# set working directory
WORKDIR /app

# copy files
COPY . .

# install project dependencies
RUN apt-get update && apt-get install -y make
RUN apt-get install -y lintian

# install go
RUN rm -rf /usr/local/go ../go
RUN apt-get install -y wget
RUN wget https://golang.org/dl/go1.22.1.linux-amd64.tar.gz

# extract go
RUN tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz
RUN rm go1.22.1.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

# install go dependencies
RUN go mod download

# package build
# CMD ["make", "build-deb"]
