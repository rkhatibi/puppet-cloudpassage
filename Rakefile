require 'puppetlabs_spec_helper/rake_tasks'
# gem 'rubocop', '~>0.34.2'
# gem 'foodcritic', '~>5.0.0'
gem 'test-kitchen', '~>1.15.0'
require 'rake'
require 'rspec'
# require 'rubocop'
# require 'foodcritic'

namespace :integration do
  require 'kitchen/cli'
  task :linux do
    desc 'Run kitchen-linux tests'
    ENV['KITCHEN_YAML'] = '.kitchen.linux.yml'
    Kitchen::CLI.new([], concurrency: 2, destroy: 'always').test
  end
  task :windows do
    desc 'Run kitchen-windows tests'
    ENV['KITCHEN_YAML'] = '.kitchen.windows.yml'
    Kitchen::CLI.new([], concurrency: 4, destroy: 'always').test
  end
end