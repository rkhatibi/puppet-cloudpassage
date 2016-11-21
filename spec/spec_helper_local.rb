# needed to perform lookups inside specs
require "hiera"

RSpec.configure do |c|
  c.default_facts = {
    "kernel"        => "Linux",
    "puppetversion" => "4.5.3",
  }

  c.fail_fast = true if ENV['FAIL_FAST'] == "true"

  # needed to evaluate hiera lookups in the puppet code
  c.hiera_config = "spec/fixtures/hiera/hiera.yaml"

  if ENV['COVERAGE'] == "true"
    c.after(:suite) do
      RSpec::Puppet::Coverage.report!
    end
  end
end

# Default to "no" as our specs fail on default facts (i.e. "$::networking")
ENV['STRICT_VARIABLES'] = "no" unless ENV['STRICT_VARIABLES']
