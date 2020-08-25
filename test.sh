#!/bin/sh


## INPUTS
INPUT_REGISTRY=$1
INPUT_BUILDARGS=$2
INPUT_IMAGENAME=$3
INPUT_TAG=$4
INOUT_DOCKERFILED_PATH=$5

## FUNCTION
addBuildArgs() {
  for ARG in $(echo "${INPUT_BUILDARGS}" | tr ',' '\n'); do
    BUILDPARAMS="${BUILDPARAMS} --build-arg ${ARG}"
    echo "[INFO] add-arg::${ARG}"
  done
}

sanitize() {
  if [ -z "${1}" ]; then
    >&2 echo "Unable to find the ${2}. Did you set with.${2}?"
    exit 1
  fi
}

useCustomDockerfile() {
  echo "[INFO] add-docker-path::${INOUT_DOCKERFILED_PATH}"
  BUILDPARAMS="${BUILDPARAMS} -f ${INOUT_DOCKERFILED_PATH}"
}

uses() {
  [ ! -z "${1}" ]
}


#### MAIN
main(){
    echo "[INFO] INPUT: $INPUT_REGISTRY,$INPUT_BUILDARGS,$INPUT_IMAGENAME,$INPUT_TAG,$INOUT_DOCKERFILED_PATH"
    BUILDPARAMS="--build-arg REGISTRY=${INPUT_REGISTRY}"
    sanitize "${INPUT_IMAGENAME}" "Image Name"

    # Check PATH
    if uses "${INOUT_DOCKERFILED_PATH}"; then
        useCustomDockerfile
    fi

    # Add Args
    addBuildArgs

    # ImageName & Tag
    BUILD_TAGS=" -t ${INPUT_IMAGENAME}:${INPUT_TAG} "

    echo "[INFO] BUILD COMMAND: docker build ${BUILDPARAMS} ${BUILD_TAGS}"
    docker build ${BUILDPARAMS} ${BUILD_TAGS}
}


main
