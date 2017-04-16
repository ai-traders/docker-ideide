load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "shellcheck is installed" {
  run ide --idefile Idefile.to_be_tested "shellcheck --version"
  assert_output --partial "ShellCheck"
  assert_output --partial "version: 0.4.6"
  assert_equal "$status" 0
}
@test "shellcheck succeeds if no style error" {
  run ide --idefile Idefile.to_be_tested "shellcheck good.sh"
  assert_equal "$status" 0
}
@test "shellcheck fails if style error" {
  run ide --idefile Idefile.to_be_tested "shellcheck bad.sh"
  assert_output --partial "Double quote"
  assert_equal "$status" 1
}
@test "shpec is installed" {
  run ide --idefile Idefile.to_be_tested "shpec --version"
  assert_output --partial "0.2.2"
  assert_equal "$status" 0
}
@test "docker daemon is running" {
  run ide --idefile Idefile.to_be_tested "docker ps -a"
  assert_output --partial "CONTAINER"
  assert_equal "$status" 0
}
@test "docker-compose is installed" {
  run ide --idefile Idefile.to_be_tested "docker-compose --version"
  assert_output --partial "docker-compose version"
  assert_equal "$status" 0
}
@test "bats is installed" {
  run ide --idefile Idefile.to_be_tested "bats --version"
  assert_output --partial "Bats 0.4.0"
  assert_equal "$status" 0
}
@test "env variable: this_image_name is set" {
  run ide --idefile Idefile.to_be_tested "env | grep this"
  assert_output --partial "this_image_name=ideide"
  assert_equal "$status" 0
}