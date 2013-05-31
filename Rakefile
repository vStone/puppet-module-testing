require 'rake'
require 'puppet-lint/tasks/puppet-lint'
require 'rspec/core/rake_task'
require 'puppetlabs_spec_helper/rake_tasks'

PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "vendor/**/*.pp"]
PuppetLint.configuration.log_format = '%{path}:%{linenumber}:%{KIND}: %{message}'

RSpec::Core::RakeTask.new(:spec_verbose) do |t|
  t.pattern = 'spec/*/*_spec.rb'
  t.rspec_opts = File.read('spec/spec.opts').chomp || ""
end

task :test do
  Rake::Task[:spec_prep].invoke
  Rake::Task[:spec_verbose].invoke
  Rake::Task[:spec_clean].invoke
end

task :default => [:spec, :lint]
