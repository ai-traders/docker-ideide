# ideide

It's a docker image to test IDE.

It can run rake tasks, shpec, shellcheck and has docker daemon installed.

## Configuration
Those files are used inside gitide docker image:
1. `~/.ssh/config` -- will be generated on docker container start
2. `~/.ssh/id_rsa` -- it must exist locally, because it is a secret
2. `~/.gitconfig` -- if exists locally, will be copied
3. `/home/ide/.profile` -- will be generated on docker container start, in 
   order to ensure current directory is `/ide/work`.
2. `~/.gemrc` -- if exists locally, will be copied

## Usage
Example Idefile:
```
IDE_DOCKER_IMAGE="docker-registry.ai-traders.com/ideide:0.0.2"
IDE_DOCKER_OPTIONS="--privileged"
```
privileged is for docker daemon.

By default current directory in docker container is `/ide/work`. Example command:
```bash
ide$ IDE_LOG_LEVEL=debug ide rake style
```
