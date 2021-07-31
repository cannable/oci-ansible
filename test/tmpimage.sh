c=$(buildah from --format docker alpine)

    buildah run $c -- apk add --no-cache \
        bash \
        dumb-init \
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
        py3-yaml \
        tcl

    buildah run $c python3 -m pip --no-cache-dir install ansible
    #buildah run $c python3 -m pip --no-cache-dir install pyvmomi
    #buildah run $c python3 -m pip --no-cache-dir install omsdk
    #buildah run $c python3 -m pip --no-cache-dir install hvac

    buildah copy \
        --chown root:root \
        --chmod 0755 \
        $c init.tcl /init.tcl

buildah commit --format docker --rm $c cannable/tmpimage
