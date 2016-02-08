task :build do
  version = File.read('scripts/docker_image_version.txt')
    .chomp()
  Rake.sh("docker build -t ideide:#{version} .")
end
