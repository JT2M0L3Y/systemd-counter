# set ubuntu base image
FROM ubuntu:latest

# set arguments
ARG GOLANG_VERSION=1.22.2

# set working directory
WORKDIR /app

# copy files
COPY . .

# install project dependencies
RUN apt-get update && apt-get install -y make wget

# download go
RUN rm -rf /usr/local/go ../go
RUN wget https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz

# extract go, set path
RUN tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

# cleanup
RUN rm go${GOLANG_VERSION}.linux-amd64.tar.gz

# run golang binary
CMD ["make", "run"]
