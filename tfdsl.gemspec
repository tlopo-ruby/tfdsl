lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tfdsl/version'

Gem::Specification.new do |spec|
  spec.name          = 'tfdsl'
  spec.version       = TFDSL::VERSION
  spec.authors       = ['Tiago Lopo']
  spec.email         = ['tlopo@github.com']

  spec.summary       = 'A chef like DSL for terraform'
  spec.description   = 'A chef like DSL for terraform'
  spec.homepage      = 'https://github.com/tlopo-ruby/tfdsl.git'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'deep_merge', '~> 1.2'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry', '~> 0.12'
  spec.add_development_dependency 'pry-coolline', '~> 0.2'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 0.63'
  spec.add_development_dependency 'simplecov', '~> 0.16'
end
