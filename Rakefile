require 'puppetlabs_spec_helper/rake_tasks'
gem 'test-kitchen', '~>1.15.0'
require 'rake'
require 'rspec'

namespace :integration do
  require 'kitchen/cli'
  task :ubuntu14 do
    desc 'Run ubuntu14 kitchen-test'
    ENV['KITCHEN_YAML'] = '.kitchen.ubuntu14.yml'
    Kitchen::CLI.new([], concurrency: 2, destroy: 'always').test
  end

  task :rhel73 do
    desc 'Run rhel73 kitchen-test'
    ENV['KITCHEN_YAML'] = '.kitchen.rhel73.yml'
    Kitchen::CLI.new([], concurrency: 2, destroy: 'always').test
  end

  task :windows do
    desc 'Run kitchen-windows tests'
    ENV['KITCHEN_YAML'] = '.kitchen.windows.yml'
    Kitchen::CLI.new([], concurrency: 4, destroy: 'always').test
  end
end