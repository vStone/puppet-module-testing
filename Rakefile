require 'rake'
require 'puppet-lint/tasks/puppet-lint'

PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "vendor/**/*.pp"]
PuppetLint.configuration.log_format = '%{path}:%{linenumber}:%{KIND}: %{message}'

task :default => [:lint]
