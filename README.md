![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103) [![GitHub license](https://img.shields.io/badge/licence-GPL--3.0-blue)](LICENSE) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-green.svg)](.github/CONTRIBUTING.md)
<br>

# bash-project-template

This is a template for bash projects. It utilises make and Docker to create safer bash scripts with DRY principle.

### Motivation

I required a build tool for my bash scripts which ensures that they are in the state I would like them regardless of the
operating system.

After doing some research I created this template for bash projects which is heavily inspired by
[zinovyev's bash-project](https://github.com/zinovyev/bash-project),
[ravi-chandran's dockerize-tutorial](https://github.com/ravi-chandran/dockerize-tutorial), and
[Yuval Peled's article 'Using Node.js to Write Safer Bash Scripts'](https://medium.com/getvim/using-node-js-to-write-safer-bash-scripts-ad6a523a5324)
.

### Features

- Uses Docker to build the scripts, this ensures a consistent build environment.
- Add safety options to scripts which will stop execution if a command fails, pipe command fails or trying to use
  undefined variables.
- Ensures line endings are correct (LF).
- Ensures all scripts are executable.
- Archives the scripts within target directory for easy distribution.
- Allows for defining functions once and using them in all scripts.

### Requirements

- [Docker to build scripts on any OS.](https://www.docker.com/)

### Building Your Scripts

Execute build script:

```bash
echo "On Linux and Mac:"
./build.sh
```

```cmd
ECHO "Windows script still needs to be added."
```

### Todo

- Allow for 'private' functions defined in src script.
- Add build script for Windows.
- Ensure auto-detected Docker name from root directory is lower-case.

### Inner Workings of the Template

__Any script located in [./src](./src) will be made with its own entrypoint:__

Script #1 [./src/script_one.sh](./src/script_one.sh):

```bash
echo "This is script one"
print_foo "foo"
print_bar "bar"
```

Script #2 [./src/script_two.sh](./src/script_two.sh):

```bash
echo "This is script two"
print_foo "foo"
print_bar "bar"
```

__Any script found in [./lib](./lib) act as modules and are intended for sharable functions:__

Module #1 [./lib/print_bar.sh](./lib/print_bar.sh):

```bash
function print_bar() {
  echo "bar: $1"
}
```

Module #2 [./lib/print_foo.sh](./lib/print_foo.sh):

```bash
function print_foo() {
  echo "foo: $1"
}
```

__Generated scripts from [./src](./src) can be found in the newly created target directory:__

Resulting file for script_one.sh found in target directory:

```bash
#!/usr/bin/env bash

set -euo pipefail

function main() {
  echo "This is script one"
  print_foo "foo"
  print_bar "bar"
}

function print_bar() {
  echo "bar: $1"
}

function print_foo() {
  echo "foo: $1"
}


main $@
```

Resulting file for script_two.sh found in target directory:

```bash
#!/usr/bin/env bash

set -euo pipefail

function main() {
  echo "This is script two"
  print_foo "foo"
  print_bar "bar"
}

function print_bar() {
  echo "bar: $1"
}

function print_foo() {
  echo "foo: $1"
}


main $@
```
