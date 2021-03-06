load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "shpec is installed" {
  run ide --idefile "${idefile}" "shpec --version"
  assert_output --partial "0.3.0"
  assert_equal "$status" 0
}
@test "docker daemon is running" {
  run ide --idefile "${idefile}" "docker ps -a"
  assert_output --partial "CONTAINER"
  assert_equal "$status" 0
}
@test "docker-compose is installed" {
  run ide --idefile "${idefile}" "docker-compose --version"
  assert_output --partial "docker-compose version"
  assert_equal "$status" 0
}
@test "bats is installed" {
  run ide --idefile "${idefile}" "bats --version"
  assert_output --partial "Bats 0.4.0"
  assert_equal "$status" 0
}
@test "env variable: this_image_name is set" {
  run ide --idefile "${idefile}" "env | grep this"
  assert_output --partial "this_image_name=ideide"
  assert_equal "$status" 0
}
@test "sort -V works" {
  run ide --idefile "${idefile}" "sort --help | grep -- '-V'"
  assert_equal "$status" 0
}
@test "wget is installed and works with https" {
  # since we git clone bats anyways, we can test wget on one of bats files
  run ide --idefile "${idefile}" "rm -f bats-readme && wget -O bats-readme https://raw.githubusercontent.com/sstephenson/bats/master/README.md && rm bats-readme"
  assert_equal "$status" 0
}
