# Build Container
FROM golang:1.9.4-alpine3.7 AS build-env
RUN apk add --no-cache --upgrade git openssh-client ca-certificates
RUN go get -u github.com/golang/dep/cmd/dep

WORKDIR /go/src/github.com/anshumanbh/gobuster

# Cache the dependencies early
COPY Gopkg.toml Gopkg.lock ./
RUN dep ensure -vendor-only -v

COPY libgobuster/ libgobuster/
COPY main.go ./

# Install the binary
RUN go install

# Final Container
FROM alpine:3.7
COPY --from=build-env /go/bin/gobuster /usr/bin/gobuster

# Copy workflow YAML
COPY wordlists wordlists

ENTRYPOINT ["/usr/bin/gobuster"]
