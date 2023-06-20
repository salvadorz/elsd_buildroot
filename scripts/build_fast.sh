#!/bin/bash
# Script to install all buildroot dependencies
# Author: Salvador Zendejas

### Saving time ###
# https://buildroot.org/downloads/manual/manual.html#make-tips

function show_usage {
    echo "Usage: $0 [--rebuild|--reconfigure|--override=/path/to/dir]"
    echo "  --rebuild            Performs 'make ${PACKAGE}-rebuild'"
    echo "  --reconfigure        Performs 'make ${PACKAGE}-reconfigure'"
    echo "  --override=/path/to/dir  Performs a local build ${OVERRIDE_DIR}"
}

# Variables
PACKAGE="aesd-assignments"

PATH_TO_LOCAL=""

COMMAND_ARG=""

CUR_DIR=`pwd`


# Procesar los argumentos
for arg in "$@"; do
    case $arg in
        --rebuild)
            if [ -n "$COMMAND_ARG" ]; then
                echo "--rebuild can not be mix with --reconfigure"
                show_usage
                exit 1
            fi
            COMMAND_ARG="${PACKAGE}-rebuild"
            ;;
        --reconfigure)
            if [ -n "$COMMAND_ARG" ]; then
                echo "--reconfigure can not be mix with --reconfigure"
                show_usage
                exit 1
            fi
            COMMAND_ARG="${PACKAGE}-reconfigure"
            ;;
        --override=*)
            PATH_TO_LOCAL="${arg#*=}"
            ;;
        --package=*)
            PACKAGE="${arg#*=}"
            ;;
    esac
done

PACKAGE_upper=$(echo "$PACKAGE" | tr '[:lower:]' '[:upper:]' | sed 's/-/_/g')

OVERRIDE_DIR="${PACKAGE_upper}_OVERRIDE_SRCDIR"

# Verificar que se haya especificado una opción válida
if [ -z "$COMMAND_ARG" ]; then
    make -C buildroot list-defconfigs
fi

# If override to a local path
if [ -n "$PATH_TO_LOCAL" ]; then

    if [ -d "${PATH_TO_LOCAL}" ]; then
        make -C buildroot ${OVERRIDE_DIR}="${PATH_TO_LOCAL}" "$COMMAND_ARG"
    else
        echo "Dir does not exist"
        exit 1
    fi
else
    make -C buildroot "$COMMAND_ARG"
fi
