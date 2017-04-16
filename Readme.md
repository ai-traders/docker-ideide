[![](https://images.microbadger.com/badges/image/xmik/ideide.svg)](https://microbadger.com/images/xmik/ideide "Get your own image badge on microbadger.com")

# ideide

An ide docker image to test [ide](https://github.com/ai-traders/ide).

It has installed:
 * shpec
 * shellcheck
 * docker daemon
 * bats

## Usage
Example Idefile:
```
IDE_DOCKER_IMAGE="xmik/ideide:2.0.0"
# --privileged is for docker daemon
IDE_DOCKER_OPTIONS="--privileged"
```

By default current directory in docker container is `/ide/work` and docker daemon
 is running. Example commands:
```bash
$ ide shellcheck ./my-script.sh
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

## Development
### Dependencies
* Bash
* Docker daemon
* Bats
* Ide

### Lifecycle
1. You make changes in a feature branch and git push it.
1. You build docker image and test it:
   * `./tasks build`
   * `./tasks itest`
1. You decide that it is time for GoCD to test and release your code, so you locally:
    * run `./tasks bump` to bump the patch version fragment by 1 or
    `./tasks bump 1.2.3` to bump to a particular version. Version is bumped in Changelog and OVersion backend.
    * merge that branch into master and push to git server
1. CI pipeline tests, releases and publishes docker image.
