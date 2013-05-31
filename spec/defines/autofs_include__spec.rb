require 'spec_helper'


describe 'autofs::include', :type => :define do
  let (:facts) { { :osfamily => 'RedHat', :operatingsystem => 'RedHat', } }

  describe 'initialize default parameters' do
    # TODO: Test the other defaulted parameters in a way.

    describe "with title: 'default'" do
      let (:title) { 'default' }

      it { should contain_file('/etc/auto.default') }
    end

    describe "with title: 'auto.foobar'" do
      let (:title) {'auto.foobar' }

      it { should contain_file('/etc/auto.foobar') }
    end


  end

  describe 'with parameter ensure => present' do
    context 'update' do
      let (:title) { 'exists' }
      let (:params) { {
        :ensure  => 'present',
        :purge   => false,
        :mapfile => '/etc/auto.newvalue',
        :mount   => '/exists'
      } }

      it { should contain_file('/etc/auto.newvalue').with_path('/etc/auto.newvalue').with_ensure('present') }

    end

    context 'add' do
      let(:title) { 'newmount' }
      let(:params) { {
        :ensure  => 'present',
        :purge   => false,
        :mapfile => '/etc/auto.newmount',
        :mount   => '/totalynew',
      } }

      it { should contain_file('/etc/auto.newmount').with_path('/etc/auto.newmount').with_ensure('present') }

    end
  end

  describe 'with parameter ensure => absent' do
    context 'and purge => false' do
      let(:title) { 'remove' }
      let(:params) { {
        :ensure  => 'absent',
        :purge   => false,
        :mapfile => '/etc/auto.remove',
        :mount   => '/remove',
      } }

      it { should contain_file('/etc/auto.remove').without_ensure('absent') }

    end

    context 'and purge => true' do
      let(:title) { 'remove' }
      let(:params) { {
        :ensure  => 'absent',
        :purge   => true,
        :mapfile => '/etc/auto.remove',
        :mount   => '/remove',
      } }

      it { should contain_file('/etc/auto.remove').with_ensure('absent') }
    end

  end

end
