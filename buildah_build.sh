#/bin/bash

. ./_build_env.sh

#if [[ $# -ne 1 ]]; then
#    echo build.sh version
#    exit 1
#fi
#
#version=$1

# Build phase

for arch in ${ARCHES[@]}; do
    build $arch
done