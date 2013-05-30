require 'spec_helper'

describe 'autofs' do

  describe 'on CentOS' do
    let (:facts) { { :osfamily => 'RedHat' } }

    it { should include_class('autofs::package') }
    it { should include_class('autofs::service') }
    it { should include_class('autofs::config') }
  end

end
