#!/bin/sh

set -ex

export COW_VERSION=0.9.8

export GOPATH=/go
export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

apk add --no-cache --virtual cow-dependencies git

mkdir -p "${GOPATH}/src" "${GOPATH}/bin"

pkgroot=github.com/cyfdecyf/cow
git clone --branch "${COW_VERSION}" https://${pkgroot}.git "${GOPATH}/src/${pkgroot}"
export CGO_ENABLED=0
go get ${pkgroot}

cd "${GOPATH}/bin"
install -c cow /usr/local/bin
cd /

rm -rf "${GOPATH}"

apk del --purge cow-dependencies
