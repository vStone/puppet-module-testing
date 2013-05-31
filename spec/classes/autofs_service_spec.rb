require 'spec_helper'

describe 'autofs::service', :type => :class do
  let (:facts) { { :osfamily => 'RedHat' } }

  describe 'default' do
    it { should contain_service('autofs').with_alias('autofs') }
  end

  describe 'inherit from autofs' do
    let (:pre_condition) { "class {'autofs': service => 'foobar', }" }
    it { should contain_service('foobar').with_alias('autofs') }
  end
end
