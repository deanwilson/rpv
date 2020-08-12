require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'invoke watchr to run tests when libs change'
task :run_watchr do
  sh 'watchr testrunner.rb'
end
