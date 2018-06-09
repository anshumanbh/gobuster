FROM golang:latest
MAINTAINER Anshuman Bhartiya

RUN mkdir -p /go/src/github.com/anshumanbh/gobuster

WORKDIR /go/src/github.com/anshumanbh/gobuster
COPY libgobuster/ libgobuster/
COPY main.go .
COPY wordlists wordlists

RUN go get && go build && go install

ENTRYPOINT [ "gobuster" ]

