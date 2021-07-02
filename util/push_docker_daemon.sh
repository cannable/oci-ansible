#!/bin/bash

. "$(dirname $(readlink -f $0))/_functions.sh"
. "$(dirname $(dirname $(readlink -f $0)))/_build_env.sh"

if [[ $# -ne 1 ]]; then
    echo Push image to local Docker
    echo push.sh version
    exit 1
fi

version=$1

for arch in ${ARCHES[@]}; do
    buildah push -f v2s2 "${IMAGE}:${arch}-${version}" "docker-daemon:${IMAGE}:${arch}-${version}"
done
