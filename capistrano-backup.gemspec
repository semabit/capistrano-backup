# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/backup/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-backup"
  spec.version       = Capistrano::Backup::VERSION
  spec.authors       = ["Shane Hofstetter"]
  spec.email         = ["shane.hofstetter@gmail.com"]

  spec.summary       = %q{Capistrano Backup Tasks.}
  spec.description   = %q{Capistrano Backup Tasks.}
  spec.homepage      = "https://github.com/semabit/capistrano-backup"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "backup-tasks"
end
