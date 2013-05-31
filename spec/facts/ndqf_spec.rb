require 'spec_helper'

describe 'Facter::Util::Fact' do

  before { Facter.clear }
  after { Facter.clear }

  test_cases =  {
    'example'      => 'example',
    'example.com'  => 'com.example',
    'www.example.com'  => 'com.example.www',
  }

  describe 'ndqf' do
    test_cases.each do |fqdn,ndqf|
      it "with fqdn '#{fqdn}' it should be '#{ndqf}'" do
        Facter.fact(:fqdn).stubs(:value).returns(fqdn)
        Facter.fact(:ndqf).value.should == ndqf
      end
    end
  end

end
