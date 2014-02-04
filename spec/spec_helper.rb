require 'rspec-puppet'
require 'rspec-puppet-augeas'
require 'hiera-puppet-helper'

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

module Helpers
  def hieraconfig(hierarchy = ['common'])
    hierarchy = [hierarchy] if hierarchy.is_a?(String)
    r = {
      :backends => ['yaml'],
      :hierarchy => hierarchy,
      :yaml => { :datadir => File.expand_path(File.join(__FILE__, '..', 'fixtures/hiera')) }
    }
    r
  end
end

RSpec.configure do |c|
  c.include Helpers
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
  c.augeas_fixtures = File.join(fixture_path, 'augeas')
  c.augeas_lensdir = File.join(File.dirname(File.expand_path(__FILE__)), '..', 'lib/augeas/lenses')
end
