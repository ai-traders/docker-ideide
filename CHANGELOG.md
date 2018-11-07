* tasks: do not fail if cannot download releaser, thus e.g. allow `./tasks build`
 to be run without releaser
* pin Shpec version, Shpec 0.3.0
* new base images: `alpine:3.8`, `debian:9.5-slim`
* ide image scripts from IDE 0.10.4
* docker 18.06.1
* docker-compose 1.23.1
* fix tests so that we can parallely test 2 docker images
* remove the need for `${HOME}/.ssh` directory, do not generate ssh config with AI-Traders endpoints

### 3.0.1 (2017-Apr-17)

* test that wget is installed (it was not on Ubuntu)
* test that wget works with https (it did not)

### 3.0.0 (2017-Apr-17)

* There will be now 2 docker images: ideide and ideide-alpine. Ide should
 work on Ubuntu/Debian and Alpine platforms.
* do not install ShellCheck. It is hard to install the same version on Alpine
 and on Ubuntu. Use koalaman/shellcheck:v0.4.6 for ShellCheck.

### 2.0.1 (2017-Apr-17)

* install coreutils so that `sort -V` works
* add colorful bash prompt with ideide in name

### 2.0.0 (2017-Apr-16)

* do not install ruby
* install bats
* docker 1.12.6-r0
* docker-compose 1.12.0
* use Alpine as base image
* better tests

# 1.0.3 (2 Sep 2016)

* install ide image configs from IDE source code from public github repository

# 1.0.2 (2 Sep 2016)

* add git.ai-traders.com and gitlab.ai-traders.com setup among /etc/ide.d/scripts
 until we stop using ruby to release IDE

# 1.0.1 (2 Sep 2016)

* fix release.sh script to push code to master branch

# 1.0.0 (2 Sep 2016)

* install ruby+docker+shpec+shellcheck
* start from ruby docker base image
* install ide image configs from IDE source code
* make it open source
* add simple tests

# 0.1.1 (14 Mar 2016)

* #8777 do not set docker storage driver
* install from apt with `--no-install-recommends` option

# 0.1.0 (11 Mar 2016)

* #8933 install docker-compose

# 0.0.2 (09 February 2016)

* Do not require `~/.ssh/config` on docker host.
* ide-fix-uid-guid.sh and ide-setup-identity.sh with safer bash variables
* #8268 set /var/lib/docker as docker volume

# 0.0.1 (09 February 2016)

Initial release #8733
