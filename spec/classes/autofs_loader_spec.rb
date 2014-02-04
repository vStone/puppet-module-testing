require 'spec_helper'

describe 'autofs::loader' do
  let (:facts) { { :osfamily => 'RedHat' } }

  describe 'single hiera yaml file' do
    let :hiera_config do
      hieraconfig(['single'])
    end

    it { should include_class('autofs::loader') }
    it { should contain_autofs__include('foobar') }
    it { should contain_autofs__mount('foo') }
    it { should contain_autofs__mount('bar') }
  end
end
