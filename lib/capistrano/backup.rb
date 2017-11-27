require "capistrano/backup/version"

if defined?(Capistrano::VERSION) && Gem::Version.new(Capistrano::VERSION).release >= Gem::Version.new("3.0.0")
  load File.expand_path("../backup/tasks.rake", __FILE__)
end
