task :build do
  version = File.read('scripts/docker_image_version.txt')
    .chomp()
  # this protects me from forgetting to bump version before building
  # the image
  if `git tag | grep #{version} -c` != "0\n"
    fail "git tag: #{version} exists already, please bump version in "\
    "scripts/docker_image_version.txt"
  end
  Rake.sh("docker build -t docker-registry.ai-traders.com/ideide:#{version} .")
end
