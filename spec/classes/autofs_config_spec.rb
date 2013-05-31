require 'spec_helper'

describe 'autofs::config', :type => :class  do
  let (:facts) { { :osfamily => 'RedHat' } }

  it { should contain_file('/etc/auto.master').with_mode('0644').with_owner('root').with_group('root') }
end
