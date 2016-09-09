[![](https://images.microbadger.com/badges/image/xmik/ideide.svg)](https://microbadger.com/images/xmik/ideide "Get your own image badge on microbadger.com")

# ideide

An ide docker image to test [IDE](https://github.com/ai-traders/ide).

It has installed:
 * ruby
 * shpec
 * shellcheck
 * docker daemon

## Usage
Example Idefile:
```
IDE_DOCKER_IMAGE="xmik/ideide:1.0.3"
# --privileged is for docker daemon
IDE_DOCKER_OPTIONS="--privileged"
```

By default current directory in docker container is `/ide/work` and docker daemon
 is running. Example commands:
```bash
$ ide rake style
$ ide shpec
$ ide docker ps -a
$ ide gem install gherkin
```

### Configuration
Those files are used inside ideide docker image:

1. `~/.ssh/config` -- will be generated on docker container start
2. `~/.ssh/id_rsa` -- it must exist locally, because it is a secret
3. `/home/ide/.profile` -- will be generated on docker container start, in
   order to ensure current directory is `/ide/work`.
4. `~/.gitconfig` -- if exists locally, will be copied
5. `~/.gemrc` -- if exists locally, will be copied

## Development
### Dependencies
Bash and Docker daemon.

### Build
1. Add any changes and increment version in `image/scripts/variables.sh`
 (no automated version management).
2. Build the docker image:
```
./build.sh
```

### Test
Run:
```
./test.sh
```

### Release
Run:
```
./release.sh
```

### TODO
* Why not use Alpine Linux as base docker image? Because I wanted to avoid
 compiling ShellCheck. But I could try compiling it using
 https://github.com/NLKNguyen/alpine-shellcheck .
* Add better acceptance tests which run `ide` commands (use BATS?).
