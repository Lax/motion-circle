# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'motion/circle/version'

Gem::Specification.new do |spec|
  spec.name          = "motion-circle"
  spec.version       = Motion::Circle::VERSION
  spec.authors       = ["Liu Lantao"]
  spec.email         = ["liulantao@gmail.com"]

  spec.summary       = %q{RubyMotion Template: Circle}
  spec.description   = %q{RubyMotion Template: Circle}
  spec.homepage      = "https://github.com/Lax/motion-circle"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  # spec.require_paths = ["lib"]

  spec.metadata     = { "rubymotion_template_dir" => "files" }

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
