FROM alpine:3.6

ENV PROTOBUF=3.5.0

# update apk first to solve No space left issue
# check out https://github.com/gliderlabs/docker-alpine/issues/231
RUN apk update && apk upgrade && \
    apk add --no-cache autoconf automake libtool curl make g++ unzip

RUN curl -SL https://github.com/google/protobuf/releases/download/v${PROTOBUF}/protobuf-cpp-${PROTOBUF}.tar.gz | tar xz

WORKDIR /protobuf-${PROTOBUF}

RUN ./autogen.sh && \
    ./configure && \
    make && \
    make check && \
    make install