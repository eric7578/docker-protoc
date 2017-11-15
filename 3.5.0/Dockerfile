FROM alpine:3.6

ENV PROTOBUF=3.5.0 \
    GOPATH=/gocode \
    PATH=/gocode/bin/:$PATH

# update apk first to solve No space left issue
# check out https://github.com/gliderlabs/docker-alpine/issues/231
RUN apk update && apk upgrade && \
    apk add --no-cache autoconf automake libtool curl make g++ unzip go git

RUN curl -SL https://github.com/google/protobuf/releases/download/v${PROTOBUF}/protobuf-cpp-${PROTOBUF}.tar.gz | tar xz && \
    cd /protobuf-${PROTOBUF} && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make check && \
    make install && \
    rm -rf /protobuf-${PROTOBUF}

RUN go get -u github.com/golang/protobuf/protoc-gen-go

COPY compile.sh /compile.sh

VOLUME [ "/proto" ]

WORKDIR /proto

ENTRYPOINT [ "sh", "/compile.sh" ]