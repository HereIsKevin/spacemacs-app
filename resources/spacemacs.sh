#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

if [ -e "${HOME}/.spacemacs.d/" ]; then
    if [ ! -e "${HOME}/.spacemacs.d/.emacs.d/" ]; then
        cp "${DIR}/../Resources/.spacemacs.d/.emacs.d/" "${HOME}/.spacemacs.d/.emacs.d/"
        HOME="${HOME}/.spacemacs.d"
        "${DIR}/Emacs.app/Contents/MacOS/emacs"
    elif [ -e "${HOME}/.spacemacs.d/.emacs.d/" ]; then
        HOME="${HOME}/.spacemacs.d"
        "${DIR}/Emacs.app/Contents/MacOS/emacs"
    fi
elif [ ! -e "${HOME}/.spacemacs.d" ]; then
    cp "${DIR}/../Resources/.spacemacs.d/" "${HOME}/.spacemacs.d/"
    HOME="${HOME}/.spacemacs.d"
    "${DIR}/Emacs.app/Contents/MacOS/emacs"
fi
