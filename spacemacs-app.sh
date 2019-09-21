#!/bin/bash

# =====Global Variables=====
BUILD="./build/"
RESOURCES="./resources/"
BUILD_DIR="./build/macOS/"

# =====Clean Build Functions=====
clean_all() {
    rm -rf "${BUILD}"
}

clean() {
    rm -rf "${BUILD_DIR}"
}

# =====Show Help Functions=====
show_help() {
    cat "./resources/helpsh.txt"
}

# =====Build Functions=====
prepare_build_dir() {
    if [ ! -e "${BUILD}" ]; then
        mkdir "${BUILD}"
    fi

    clean

    mkdir "${BUILD_DIR}"
}

get_icons() {
    local wget_exists=`which wget > /dev/null; echo $?`
    local curl_exists=`which curl > /dev/null; echo $?`

    if [[ wget_exists == 1 ]] && [[ curl_exists == 1 ]]; then
        echo "error: either curl or wget must be installed"
        exit 1
    elif [[ wget_exists != 1 ]]; then
        rm "${RESOURCES}/spacemacs.icns"
        wget "https://github.com/nashamri/spacemacs-logo/raw/master/spacemacs.icns"
        mv "./spacemacs.icns" "${RESOURCES}/spacemacs.icns"
    elif [[ curl_exists != 1 ]]; then
        rm "${RESOURCES}/spacemacs.icns"
        curl -O "https://github.com/nashamri/spacemacs-logo/raw/master/spacemacs.icns"
        mv "./spacemacs.icns" "${RESOURCES}/spacemacs.icns"
    fi
}

make_app() {
    mkdir "${BUILD_DIR}/Spacemacs.app/"
    mkdir "${BUILD_DIR}/Spacemacs.app/Contents/"
    mkdir "${BUILD_DIR}/Spacemacs.app/Contents/MacOS"
    mkdir "${BUILD_DIR}/Spacemacs.app/Contents/Resources"
    cp "${RESOURCES}/infoplist.xml" "${BUILD_DIR}/Spacemacs.app/Contents/Info.plist"
    cp "${RESOURCES}/spacemacs.icns" "${BUILD_DIR}/Spacemacs.app/Contents/Resources/spacemacs.icns"
    echo "APPL????" > "${BUILD_DIR}/Spacemacs.app/Contents/Pkginfo"
    mkdir "${BUILD_DIR}/Spacemacs.app/Contents/Resources/.spacemacs.d/"
    mkdir "${BUILD_DIR}/Spacemacs.app/Contents/Resources/.spacemacs.d/"

    if [[ `which git > /dev/null; echo $?` == 1 ]]; then
        echo "error: git must be installed"
        exit 1
    fi

    git clone "https://github.com/syl20bnr/spacemacs/" "${BUILD_DIR}/Spacemacs.app/Contents/Resources/.spacemacs.d/.emacs.d/"

    local wget_exists=`which wget > /dev/null; echo $?`
    local curl_exists=`which curl > /dev/null; echo $?`

    if [ ! -e "./resources/Emacs-26.3-universal.dmg" ]; then
        if [[ wget_exists == 1 ]] && [[ curl_exists == 1 ]]; then
            echo "error: either curl or wget must be installed"
            exit 1
        elif [[ wget_exists != 1 ]]; then
            wget "https://emacsformacosx.com/emacs-builds/Emacs-26.3-universal.dmg"
            mv "./Emacs-26.3-universal.dmg" "${RESOURCES}/Emacs-26.3-universal.dmg"
        elif [[ curl_exists != 1 ]]; then
            curl -O "https://emacsformacosx.com/emacs-builds/Emacs-26.3-universal.dmg"
            mv "./Emacs-26.3-universal.dmg" "${RESOURCES}/Emacs-26.3-universal.dmg"
        fi
    fi

    hdiutil mount "${RESOURCES}/Emacs-26.3-universal.dmg"
    ditto "/Volumes/Emacs/Emacs.app/" "${BUILD_DIR}/Spacemacs.app/Contents/MacOS/Emacs.app/"
    hdiutil unmount "/Volumes/Emacs/"

    cp "${RESOURCES}/spacemacs.sh" "${BUILD_DIR}/Spacemacs.app/Contents/MacOS/spacemacs"
    chmod +x "${BUILD_DIR}/Spacemacs.app/Contents/MacOS/spacemacs"
}

build() {
    clean
    prepare_build_dir
    get_icons
    make_app
}

args_parse() {
    if [[ $1 == "--help" ]] || [[ $1 == "-h" ]] || [[ $1 == "" ]]; then
        show_help
    elif [[ $1 == "--clean" ]] || [[ $1 == "-c" ]]; then
        if [[ $2 == "all" ]]; then
            clean_all
        elif [[ $2 == "build" ]] || [[ $2 == "" ]]; then
            clean
        fi
    elif [[ $1 == "-call" ]]; then
        clean_all
    elif [[ $1 == "-cbuild" ]]; then
        clean
    elif [[ $1 == "--build" ]] || [[ $1 == "-b" ]]; then
        build
    fi
}

args_parse $@
