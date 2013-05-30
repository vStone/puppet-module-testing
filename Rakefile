require 'rake'
require 'puppet-lint/tasks/puppet-lint'
require 'rspec/core/rake_task'

PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "vendor/**/*.pp"]
PuppetLint.configuration.log_format = '%{path}:%{linenumber}:%{KIND}: %{message}'
PuppetLint.configuration.send('disable_autoloader_layout')

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end

RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = 'spec/*/*_spec.rb'
  t.rspec_opts = File.read('spec/spec.opts').chomp || ""
end

task :default => [:spec, :lint]
