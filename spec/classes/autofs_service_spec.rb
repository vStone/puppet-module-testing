require 'spec_helper'

describe 'autofs::service', :type => :class do
  let (:facts) { { :osfamily => 'RedHat' } }

  it { should contain_service('autofs').with_alias('autofs') }
end
