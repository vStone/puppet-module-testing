require 'spec_helper'

describe 'parse_autofs_options' do

  tests = {
    'string'  => 'rw,foo,bar=,foobar=foobar',
    '-string' => '-rw,foo,bar=,foobar=foobar',
    'array'   => ['rw','foo','bar=','foobar=foobar'],
    'hash'    => {'rw' => nil, 'foo' => nil, 'bar' => nil, 'foobar' => 'foobar'},
    'dirtyhash' => {'rw' => nil, 'foo' => '', 'bar' => ' ', 'foobar' => 'foobar'},
  }
  result = {
    'rw' => nil,
    'foo' => nil,
    'bar' => nil,
    'foobar' => 'foobar'
  }

  tests.each do |type,data|
    it "should run with #{type}" do
      should run.with_params(data).and_return(result)
    end
  end

  it "should fail with no arguments" do
    should run.with_params(nil).and_raise_error(Puppet::ParseError)
  end


end
