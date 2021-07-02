# ------------------------------------------------------------------------------
# Ansible Container
# ------------------------------------------------------------------------------
# This container has Ansible and a few Dell and VMware modules installed.

IMAGE="cannable/ansible"
#ARCHES=(amd64 arm64 arm)
ARCHES=(amd64)

build() {

    arch=$1

    echo Building $arch...

    c=$(buildah from --arch "$arch" alpine)

    buildah run $c -- apk update
    buildah run $c -- apk add --no-cache \
        bash \
        python3 \
        py3-asn1 \
        py3-asn1crypto \
        py3-bcrypt \
        py3-cffi \
        py3-cparser \
        py3-cryptography \
        py3-idna \
        py3-jinja2 \
        py3-markupsafe \
        py3-packaging \
        py3-paramiko \
        py3-parsing \
        py3-pip \
        py3-pynacl \
        py3-six \
        py3-wheel \
        py3-yaml

    buildah run $c python3 -m pip --no-cache-dir install ansible
    buildah run $c python3 -m pip --no-cache-dir install pyvmomi


    buildah run $c adduser -u 1000 -g 1000 -D ansible

    buildah config  \
        --user 1000:1000 \
        --volume /home/ansible \
        --workingdir /home/ansible \
        $c

    buildah commit --rm $c $IMAGE
}