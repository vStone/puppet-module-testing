require 'spec_helper'

describe 'autofs::config', :type => :class  do
  let (:facts) { { :osfamily => 'RedHat' } }

  describe 'with default parameters' do
    it { should contain_file('/etc/auto.master').with_mode('0644').with_owner('root').with_group('root') }
  end

  describe 'with custom parameters' do
    let (:params) { { :mode   => '0640', } }

    it { should contain_file('/etc/auto.master').with_mode('0640') }
  end
end
