# ------------------------------------------------------------------------------
# Generic Function Definitions
# ------------------------------------------------------------------------------
# Override any of these in _build_env.sh.


build() {
    arch=$1

    echo Building $arch...
    buildah bud --arch "$arch" --tag "${IMAGE}:${arch}-${version}" --build-arg "${VERSION_ARG}=${version}" -f ./Dockerfile .
}
