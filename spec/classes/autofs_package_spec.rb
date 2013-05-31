require 'spec_helper'


describe 'autofs::package' do
  let (:facts) { { :osfamily => 'RedHat' } }

  it { should contain_package('autofs').with_alias('autofs').with_ensure('installed') }
end
