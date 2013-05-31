require 'spec_helper'


describe 'autofs::package' do
  let (:facts) { { :osfamily => 'RedHat' } }

  describe 'default' do
    it { should contain_package('autofs').with_alias('autofs').with_ensure('installed') }
  end

  describe 'inherit from autofs' do
    let (:pre_condition) { "class {'autofs': package => 'foobar', }" }
    it { should contain_package('foobar').with_alias('autofs').with_ensure('installed') }
  end
end
