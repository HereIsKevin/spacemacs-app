# spacemacs-app: Prebuilt Binaries of Spacemacs
Spacemacs advertises itself as a good Emacs configuration, being ergonomic, mnemonic, and consistent. It is a good, powerful configuration, but its design causes it to be hard to introduce to beginner. Also, it is annoying to run Spacemacs in parallel with another Emacs configuration. With that in mind, spacemacs-app  is the solution to most of these problems. The binaries for spacemacs-app are prebuilt, self-contained, and are isolated from any other Emacs installation.

## Table of Contents

- [Installation](#installation)
- [Building](#building)
- [Contributing](#contributing)

## Installation

Currently, spacemacs-app is macOS only. To install, simply head over to the [latest release](https://github.com/HereIsKevin/spacemacs-app/releases/latest), and download the **spacemacs-app-macOS-v\*.\*.\*.zip**. Extract it, and move the **"Spacemacs"** app to the Applications folder.

## Building

**Warning, this is for people who want build their own "Spacemacs" app only. ** Open up a the macOS terminal (macOS is required for building), and enter the following, without the `$` symbol.

```sh
$ git clone https://github.com/HereIsKevin/spacemacs-app.git # Clone the repository
$ cd /path/to/spacemacs-app/ # Replace /path/to/spacemacs-app/ with the actual path
# =====The following shows the instructions for using the script=====
$ ./spacemacs-app.sh --help
usage: ./spacemacs-app.sh [--help | -h] [--clean | -c [<all|build>]]
                          [--build | -b]

options:
    --help, -h          show this help message
    --clean, -c         clean the build directories, use "all" for everything
                        or "build" or nothing for just the current build
    --build, -b         build the app for release
# =====DO NOT TYPE IT=====
$ ./spacemacs-app.sh --build # Enter this command to build, or use the help message
# ...lots of output...
$ cd ./build/macOS/ # Go to the build directory
$ open ./ # Open the Finder to show the build
```

## Contributing

Contributions are welcome, open a pull request for me to verify. Currently, I would helpful for someone to achieve the following tasks:

- Create a PowerShell build script for a Windows build with installer
- Throughly test the macOS build script and app to find bugs

**I DO NOT NEED ANYONE DOING THE FOLLOWING TASKS:**

- Create a Linux build (Linux is too hard to support, and Linux users should know how to use Spacemacs without a "walkthru" type of build) 