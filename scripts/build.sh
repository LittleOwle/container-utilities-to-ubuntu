#!/bin/env bash

GO_VERSION=1.22.0
UMOCI_VERSION=v0.4.7
RUNC_VERSION=v1.1.13
CONMON_VERSION=v2.1.12
GO_MD2MAN_VERSION=v2.0.4
RUNC_VERSION=v1.1.13
BUILD_EXPORTS=

EXTERNALS_SOURCE_FOLDER=/opt/owle-externals/source
EXTERNALS_BUILD_FOLDER=/opt/owle-externals/build

mkdir -p $EXTERNALS_SOURCE_FOLDER
mkdir -p $EXTERNALS_BUILD_FOLDER/conmon
mkdir -p $EXTERNALS_BUILD_FOLDER/go-md2man/bin
mkdir -p $EXTERNALS_BUILD_FOLDER/umoci
mkdir -p $EXTERNALS_BUILD_FOLDER/runc

export GOPATH=$EXTERNALS_BUILD_FOLDER/go

## GO v${GO_VERSION}
cd $EXTERNALS_SOURCE_FOLDER
wget -c https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz
tar -C $EXTERNALS_BUILD_FOLDER -xzf go${GO_VERSION}.linux-amd64.tar.gz
BUILD_EXPORTS=$GOPATH/bin
export PATH=$GOPATH/bin:$PATH
go get github.com/seccomp/libseccomp-golang
go version

## Go-md2man ${GO_MD2MAN_VERSION}
git clone https://github.com/cpuguy83/go-md2man.git $EXTERNALS_SOURCE_FOLDER/go-md2man
cd $EXTERNALS_SOURCE_FOLDER/go-md2man
git checkout ${GO_MD2MAN_VERSION}
go build -o $EXTERNALS_BUILD_FOLDER/go-md2man/bin
export GO_MD2MAN=$EXTERNALS_BUILD_FOLDER/go-md2man/bin/go-md2man
BUILD_EXPORTS=$EXTERNALS_BUILD_FOLDER/go-md2man/bin:${BUILD_EXPORTS}
export PATH=$EXTERNALS_BUILD_FOLDER/go-md2man/bin:$PATH

## Conmon ${CONMON_VERSION}
git clone https://github.com/containers/conmon.git $EXTERNALS_SOURCE_FOLDER/conmon
cd $EXTERNALS_SOURCE_FOLDER/conmon
git checkout ${CONMON_VERSION}
export GOCACHE="$(mktemp -d)"
make PREFIX=$EXTERNALS_BUILD_FOLDER/conmon
make install PREFIX=$EXTERNALS_BUILD_FOLDER/conmon
BUILD_EXPORTS=$EXTERNALS_BUILD_FOLDER/conmon/bin:${BUILD_EXPORTS}
export PATH=$EXTERNALS_BUILD_FOLDER/conmon/bin:$PATH
conmon --version

## Umoci ${UMOCI_VERSION}
git clone https://github.com/opencontainers/umoci.git $EXTERNALS_SOURCE_FOLDER/umoci
cd $EXTERNALS_SOURCE_FOLDER/umoci
git checkout ${UMOCI_VERSION}
make PREFIX=$EXTERNALS_BUILD_FOLDER/umoci GO_MD2MAN=$EXTERNALS_BUILD_FOLDER/go-md2man/bin/go-md2man
make install PREFIX=$EXTERNALS_BUILD_FOLDER/umoci
BUILD_EXPORTS=$EXTERNALS_BUILD_FOLDER/umoci/bin:${BUILD_EXPORTS}
export PATH=$EXTERNALS_BUILD_FOLDER/umoci/bin:$PATH

## RunC ${RUNC_VERSION}
git clone https://github.com/opencontainers/runc.git $EXTERNALS_SOURCE_FOLDER/runc
cd $EXTERNALS_SOURCE_FOLDER/runc
git checkout ${RUNC_VERSION}
make PREFIX=$EXTERNALS_BUILD_FOLDER/runc
make install PREFIX=$EXTERNALS_BUILD_FOLDER/runc
BUILD_EXPORTS=$EXTERNALS_BUILD_FOLDER/runc/sbin:${BUILD_EXPORTS}
export PATH=$EXTERNALS_BUILD_FOLDER/runc/sbin:$PATH

runc --version
echo ""
echo "===================================="
echo "Build done!"
echo "versions:"
echo "go: v${GO_VERSION}"
echo "go-md2man: ${GO_MD2MAN_VERSION}"
echo "conmon: ${CONMON_VERSION}"
echo "umoci: ${UMOCI_VERSION}"
echo "runC: ${RUNC_VERSION}"
echo "===================================="
echo "exports:"
echo "export PATH=${BUILD_EXPORTS}:\$PATH"
echo "===================================="
echo ""

exit 0
