# ------------------------------------------------------------------------------
# Ansible Container
# ------------------------------------------------------------------------------
# This container has Ansible and a few Dell and VMware modules installed.

IMAGE="cannable/ansible"
#ARCHES=(amd64 arm64 arm)
ARCHES=(amd64 arm64)

build() {

    arch=$1

    echo Building $arch...

    c=$(buildah from --format docker --arch "$arch" alpine)

    buildah run $c -- apk add --no-cache \
        bash \
        python3 \
        openssh \
        py3-asn1 \
        py3-asn1crypto \
        py3-bcrypt \
        py3-certifi \
        py3-cffi \
        py3-cparser \
        py3-cryptography \
        py3-future \
        py3-idna \
        py3-ipaddress \
        py3-jinja2 \
        py3-markupsafe \
        py3-packaging \
        py3-paramiko \
        py3-parsing \
        py3-pip \
        py3-ply \
        py3-pycryptodomex \
        py3-pynacl \
        py3-requests \
        py3-six \
        py3-snmp \
        py3-wheel \
        py3-yaml

    buildah run $c python3 -m pip --no-cache-dir install ansible
    buildah run $c python3 -m pip --no-cache-dir install pyvmomi
    buildah run $c python3 -m pip --no-cache-dir install omsdk
    buildah run $c python3 -m pip --no-cache-dir install hvac


    buildah run $c adduser -u 1000 -g 1000 -D ansible

    buildah config  \
        --user 1000:1000 \
        --shell '/bin/bash -c' \
        --volume /home/ansible \
        --workingdir /home/ansible \
        $c

    buildah commit --format docker --rm $c "$IMAGE:${arch}-latest"
}