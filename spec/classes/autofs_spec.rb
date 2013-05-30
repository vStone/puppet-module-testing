require 'spec_helper'

describe 'autofs' do

  describe 'on CentOS' do
    let (:facts) { { :osfamily => 'RedHat' } }

    it { should include_class('autofs::package') }
    it { should include_class('autofs::service') }
    it { should include_class('autofs::config') }
  end

  describe 'on another OS' do
    let (:facts) { { :osfamily => 'Something' } }

    it do
      expect {
        should include_class('autofs::params')
      }.to raise_error(Puppet::Error, /osfamily not supported:/)
    end
  end

end
