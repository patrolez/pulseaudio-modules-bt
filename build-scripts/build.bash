#!/bin/bash
: ${1?"$(printf '%s\n' "Need a parameter! Which distribution would you like to build?" "$( for fn in *.Dockerfile; do printf '> %s\n' "${fn%.Dockerfile}"; done )")"}

ensure_that_has_permissions() {
    if ! docker version
    then
        echo >&2
        echo "Most likely you have no permisison to use docker! Aborting!" >&2
        exit 1
    fi
}

main() {
    local TGT="$1"
    (
        set -e
        docker build -t "tmp.remove.${TGT}" -f "${TGT}.Dockerfile" .
        local RESPECTIVE_USR=$(id -u "$(logname)")
        local RESPECTIVE_USR_GRP=$(id -g "${RESPECTIVE_USR}")
        docker run --rm --entrypoint /bin/bash "tmp.remove.${TGT}" -c \
            "tar -cf - /dist --owner=${RESPECTIVE_USR} --group=${RESPECTIVE_USR_GRP}" | tar -x
        echo "This script will not clean-up itself Docker Images!" >&2
    )
}

ensure_that_has_permissions
main "$@"