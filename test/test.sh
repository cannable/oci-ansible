#!/bin/sh

c=$(buildah from --format docker cannable/tmpimage)

#    buildah copy \
#        --chown root:root \
#        --chmod 0755 \
#        $c init.sh /init.sh

buildah copy \
	--chown root:root \
	--chmod 0755 \
	$c init.tcl /init.tcl

buildah copy \
	--chown root:root \
	--chmod 0755 \
	$c ./test/arg_echo.sh /arg_echo.sh

buildah config  \
	--env "CONTAINER_USER=ansible" \
	--env "CONTAINER_UID=1000" \
	--env "CONTAINER_GID=1000" \
	--env "CONTAINER_HOME=/home/ansible" \
	--entrypoint '["/usr/bin/dumb-init", "--", "/init.tcl"]' \
	--cmd '["ansible"]' \
	$c

buildah commit --format docker --rm $c cannable/inittest

podman run -it --rm --name junk cannable/inittest:latest

