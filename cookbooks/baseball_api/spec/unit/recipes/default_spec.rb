#
# Cookbook:: baseball_api
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'baseball_api::default' do
      let(:chef_run) do
        # for a complete list of available platforms and versions see:
        # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
        runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
        runner.converge(described_recipe)
      end

      it 'should install MySQL libraries' do
        expect(chef_run).to install_apt_package('libmysqlclient-dev')
      end

      it 'should install Python libraries' do
        expect(chef_run).to install_apt_package('python-mysqldb')
        expect(chef_run).to install_apt_package('build-essential')
        expect(chef_run).to install_apt_package('python-dev')
        expect(chef_run).to install_apt_package('zlib1g-dev')
        expect(chef_run).to install_apt_package('libssl-dev')
      end

      it 'includes the app recipe' do
        expect(chef_run).to include_recipe('baseball_api::app')
      end

      it 'includes the server recipe' do
        expect(chef_run).to include_recipe('baseball_api::server')
      end

      it 'includes the database recipe' do
        expect(chef_run).to include_recipe('baseball_api::database')
      end

      it 'includes the searchEngine recipe' do
        expect(chef_run).to include_recipe('baseball_api::searchEngine')
      end
end
