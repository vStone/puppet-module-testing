source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "~> #{ENV['PUPPET_VERSION']}" : ['~> 3']
gem 'puppet', puppetversion

# working around ruby version $@^!
#gem 'mime-types', (RUBY_VERSION =~ /^1.8/ ? '~> 1.25.1' : nil)

gem 'rake'
gem 'puppet-lint'
gem 'rspec'
gem 'rspec-puppet', '= 0.1.6'
gem 'puppetlabs_spec_helper'
gem 'rspec-puppet-augeas'
gem 'ruby-augeas'
