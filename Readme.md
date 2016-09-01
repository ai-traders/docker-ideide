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
IDE_DOCKER_IMAGE="ideide:1.0.0"
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
1. `/home/ide/.profile` -- will be generated on docker container start, in
   order to ensure current directory is `/ide/work`.
2. `~/.gemrc` -- if exists locally, will be copied
3. `~/.gitconfig` -- if exists locally, will be copied

## Development
### Build
1. Add any changes and increment version in `image/scripts/variables.sh`
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
