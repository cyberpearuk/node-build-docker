#! /bin/bash
# Convenience script for building and starting up
set -e

TAG=cyberpearuk/node-build-docker:development


push() {
    echo "Pushing tag" 
    docker push ${TAG}
}

build() {
    docker build -t ${TAG} .
}

run() {
    docker run --rm -it -eNPM_REGISTRY=https://default.registry.org/  -eNPM_PASS=defaultpass -eNPM_USER=defaultuser  -eNPM_REGISTRY_MYORG=https://user:pass@my.repository/repository/npm/ ${TAG} npm config list
}

case $1 in
    "build")
        build
    ;;
    "run")
        run
    ;;
    "push")
        push
    ;;
    "build-run")
        build
        run
    ;;
    "build-push")
        build
        push
    ;;
    *)
        echo "Specify 'build', 'run', 'build-run'"
    ;;
esac