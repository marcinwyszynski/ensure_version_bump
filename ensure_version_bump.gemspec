# encoding: utf-8

Gem::Specification.new do |spec|
  spec.name    = 'ensure_version_bump'
  spec.version = '0.1.0'

  spec.author      = 'Marcin Wyszynski'
  spec.summary     = 'CI helper for Ruby gems to ensure version bump'
  spec.description = spec.summary
  spec.homepage    = 'https://github.com/marcinwyszynski/ensure_version_bump'
  spec.license     = 'MIT'

  spec.bindir      = 'bin'
  spec.files       = ['lib/ensure_version_bump.rb']
  spec.test_files  = spec.files.grep(/^spec/)
  spec.executables = ['ensure_version_bump']

  spec.add_runtime_dependency 'colorize', '~> 0.8', '>= 0.8.1'
  spec.add_development_dependency 'bundler', '~> 1.14', '>= 1.14.6'
  spec.add_development_dependency 'rake', '~> 12.0'
end # Gem::Specification
