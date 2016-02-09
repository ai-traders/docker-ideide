task :build do
  version = File.read('scripts/docker_image_version.txt')
    .chomp()
  Rake.sh("docker build -t docker-registry.ai-traders.com/ideide:#{version} .")
end
