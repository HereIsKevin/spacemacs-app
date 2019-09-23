#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ -e "${HOME}/.spacemacs.d/" ]; then
    if [ ! -e "${HOME}/.spacemacs.d/.emacs.d/" ]; then
        cp -r "${DIR}/../Resources/.spacemacs.d/.emacs.d/" "${HOME}/.spacemacs.d/.emacs.d/"
        HOME="${HOME}/.spacemacs.d"
        "${DIR}/Emacs.app/Contents/MacOS/emacs"
    else
        HOME="${HOME}/.spacemacs.d/"
        "${DIR}/Emacs.app/Contents/MacOS/emacs"
    fi
else
    cp -r "${DIR}/../Resources/.spacemacs.d/" "${HOME}/.spacemacs.d/"
    HOME="${HOME}/.spacemacs.d"
    "${DIR}/Emacs.app/Contents/MacOS/emacs"
fi
