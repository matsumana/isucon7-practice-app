#!/usr/bin/env bash

if [ -z "${CI}" ]; then  # if CI is not empty, I am supposed to being running on jenkins.linecorp.com
    if [ "$(uname)" = "Linux" ] && [ "$(whoami)" != "root" ]; then
        echo "Must be root user to execute docker command"
        exit 1
    fi
fi

set -eu

repository='github.com/matsumana/isucon7-practice-app'

BIN_DIR="bin"

CONTAINER_NAME="isucon7-practice-app"

# Setup
rm -rf "${BIN_DIR}" && mkdir -pv "${BIN_DIR}"

# Stop the container if they are running
set +e
docker stop "${CONTAINER_NAME}"
# usually we don't need to execute `docker rm`
docker rm "${CONTAINER_NAME}" > /dev/null 2>&1
set -e

GOARCH="amd64"

# Build automator-server
for GOOS in darwin linux
do
    echo "Build application for ${GOOS}"
    docker run --rm --name "${CONTAINER_NAME}" -e GOARCH="${GOARCH}" -e GOOS="${GOOS}" \
        -v "$(pwd)":/go/src/${repository} -w /go/src/${repository} golang \
        go build -v -o "${BIN_DIR}/app-${GOOS}-${GOARCH}"
done

# Show built the application
echo
ls -l "${BIN_DIR}"

# EOF

