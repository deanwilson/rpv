Gem::Specification.new do |spec|
  spec.name        = 'running-process-verifier'
  spec.version     = '0.1.0'
  spec.homepage    = 'https://github.com/deanwilson/rpv'
  spec.license     = 'GPLv2'
  spec.author      = 'Dean Wilson'
  spec.email       = 'dean.wilson@gmail.com'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'running-process-verifier'
  spec.description = <<-DESCRIPTION
    Check that every process running on a machine is expected to be present.
  DESCRIPTION

  spec.add_development_dependency 'rake', '~> 13.0.0'
  spec.add_development_dependency 'rspec', '~> 3.9.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-json_expectations', '~> 2.2'
  spec.add_development_dependency 'rubocop', '~> 0.89.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.42.0'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
end
