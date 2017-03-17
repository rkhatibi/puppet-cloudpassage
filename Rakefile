require 'puppetlabs_spec_helper/rake_tasks'
gem 'test-kitchen', '~>1.15.0'
require 'rake'
require 'rspec'

namespace :integration do
  require 'kitchen/cli'
  task :ubuntu do
    desc 'Run ubuntu kitchen-test'
    ENV['KITCHEN_YAML'] = '.kitchen.ubuntu.yml'
    Kitchen::CLI.new([], concurrency: 2, destroy: 'always').test
  end

  task :rhel do
    desc 'Run rhel kitchen-test'
    ENV['KITCHEN_YAML'] = '.kitchen.rhel.yml'
    Kitchen::CLI.new([], concurrency: 2, destroy: 'always').test
  end

  task :amzn do
    desc 'Run amzn kitchen-test'
    ENV['KITCHEN_YAML'] = '.kitchen.amzn.yml'
    Kitchen::CLI.new([], concurrency: 2, destroy: 'always').test
  end

  task :centos do
    desc 'Run centos kitchen-test'
    ENV['KITCHEN_YAML'] = '.kitchen.centos.yml'
    Kitchen::CLI.new([], concurrency: 2, destroy: 'always').test
  end

  task :debian do
    desc 'Run debian kitchen-test'
    ENV['KITCHEN_YAML'] = '.kitchen.debian.yml'
    Kitchen::CLI.new([], concurrency: 2, destroy: 'always').test
  end

  task :oracle do
    desc 'Run oracle kitchen-test'
    ENV['KITCHEN_YAML'] = '.kitchen.oracle.yml'
    Kitchen::CLI.new([], concurrency: 2, destroy: 'always').test
  end

  task :windows do
    desc 'Run kitchen-windows tests'
    ENV['KITCHEN_YAML'] = '.kitchen.windows.yml'
    Kitchen::CLI.new([], concurrency: 4, destroy: 'always').test
  end
end