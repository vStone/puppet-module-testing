require 'spec_helper'


describe 'autofs::include', :type => :define do
  let (:facts) { { :osfamily => 'RedHat', :operatingsystem => 'RedHat', } }

  describe 'initialize default parameters' do
    # TODO: Test the other defaulted parameters in a way.
    #

    describe "with title: 'default'" do
      let (:title) { 'default' }

      it { should contain_file('/etc/auto.default') }
      it { should contain_augeas('autofs::include::add-/default').with_onlyif(/\[\.\s\=\s'\/default'\]/) }
    end

    describe "with title: 'auto.foobar'" do
      let (:title) {'auto.foobar' }

      it { should contain_file('/etc/auto.foobar') }
      it { should contain_augeas('autofs::include::add-/foobar').with_onlyif(/\[\.\s\=\s'\/foobar'\]/) }
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

      it { should contain_augeas('autofs::include::update-/exists') }
      it { should contain_file('/etc/auto.newvalue').with_path('/etc/auto.newvalue').with_ensure('present') }

      describe_augeas 'autofs::include::update-/exists', :lens => 'Automaster', :target => 'etc/auto.master' do
        it 'should modify existing value' do
          should execute.with_change
          aug_get('*[. = "/exists"]/map').should == '/etc/auto.newvalue'
          should execute.idempotently
        end
      end
    end

    context 'add' do
      let(:title) { 'newmount' }
      let(:params) { {
        :ensure  => 'present',
        :purge   => false,
        :mapfile => '/etc/auto.newmount',
        :mount   => '/totalynew',
      } }

      it { should contain_augeas('autofs::include::add-/totalynew') }
      it { should contain_file('/etc/auto.newmount').with_path('/etc/auto.newmount').with_ensure('present') }

      describe_augeas 'autofs::include::add-/totalynew', :lens => 'Automaster', :target => 'etc/auto.master' do
        it 'should add a new entry' do
          should execute.with_change
          aug_get('*[. = "/totalynew"]/map').should == '/etc/auto.newmount'
          should execute.idempotently
        end
      end
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

      it { should contain_augeas('autofs::include::rm-/remove') }
      it { should contain_file('/etc/auto.remove').without_ensure('absent') }

      describe_augeas 'autofs::include::rm-/remove', :lens => 'Automaster', :target => 'etc/auto.master' do
        it 'should remove an entry' do
          should execute.with_change
          aug_get('*[. = "/remove"]').should == nil
          should execute.idempotently
        end
      end

    end

    context 'and purge => true' do
      let(:title) { 'remove' }
      let(:params) { {
        :ensure  => 'absent',
        :purge   => true,
        :mapfile => '/etc/auto.remove',
        :mount   => '/remove',
      } }

      it { should contain_augeas('autofs::include::rm-/remove') }
      it { should contain_file('/etc/auto.remove').with_ensure('absent') }
    end

  end

end
