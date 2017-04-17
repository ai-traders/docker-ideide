[![](https://images.microbadger.com/badges/image/xmik/ideide.svg)](https://microbadger.com/images/xmik/ideide "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/xmik/ideide-alpine.svg)](https://microbadger.com/images/xmik/ideide-alpine "Get your own image badge on microbadger.com")

# ideide

An ide docker image to test [ide](https://github.com/ai-traders/ide).

It has installed:
 * shpec
 * bats
 * docker daemon
 * docker-compose

## Usage
### Ubuntu based
Example Idefile:
```
IDE_DOCKER_IMAGE="xmik/ideide:3.0.1"
# --privileged is for docker daemon
IDE_DOCKER_OPTIONS="--privileged"
```
### Alpine based
Example Idefile:
```
IDE_DOCKER_IMAGE="xmik/ideide-alpine:3.0.1"
# --privileged is for docker daemon
IDE_DOCKER_OPTIONS="--privileged"
```

### Commands
By default current directory in docker container is `/ide/work` and docker daemon
 is running. Example commands:
```bash
$ ide shpec
$ ide docker ps -a
$ ide docker-compose --version
$ ide bats --version
```

### Configuration
Those files are used inside ideide docker image:

1. `~/.ssh/config` -- will be generated on docker container start
2. `~/.ssh/id_rsa` -- it must exist locally, because it is a secret
3. `/home/ide/.profile` -- will be generated on docker container start, in
   order to ensure current directory is `/ide/work`.
4. `~/.gitconfig` -- if exists locally, will be copied

## Development and contributions
### Dependencies
* Bash
* Docker daemon
* Bats
* Ide

### Lifecycle
1. You make changes in a feature branch and git push it.
1. You build docker images and test them:
  * `./tasks build`
  * `./tasks itest`
  * `./tasks build_alpine`
  * `./tasks itest_alpine`
1. If you decide that your code is ready, create a PR. Your job as a contributor
is done.

Then:
1. Maintainer merges PR(s) into master branch.
1. Maintainer runs locally:
  * `./tasks bump` to bump the patch version fragment by 1 OR
  * e.g. `./tasks bump 1.2.3` to bump to a particular version
    Version is bumped in Changelog, variables.sh file and OVersion backend.
1. Everything is pushed to master onto private git server.
1. CI server (GoCD) tests and releases.
1. After successful CI server pipeline, maintainer:
  * pushes master code to github
  * triggers build on docker hub
  * tags ideide-alpine image as xmik/ideide-alpine and pushes to docker hub
