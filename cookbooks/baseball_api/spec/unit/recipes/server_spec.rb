#
# Cookbook:: baseball_api
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'baseball_api::server' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.node.normal['app']['location'] = '/test/dir'
      runner.converge(described_recipe)
    end

    it 'includes the nginx recipe' do
      expect(chef_run).to include_recipe('chef_nginx::default')
    end

    it 'creates the ini file' do
      expect(chef_run).to create_template('/test/dir/pybaseball.ini')
        .with_source('app.ini.erb')
    end

    it 'creates the systemd service' do
      expect(chef_run).to create_template('/etc/systemd/system/pybaseball.service')
        .with_source('app.service.erb')
    end

    it 'creates the nginx configuration' do
      expect(chef_run).to create_template('/etc/nginx/sites-available/pybaseball')
        .with_source('nginx.site.erb')
    end

    it 'creates the nginx sites enabled link' do
      expect(chef_run).to create_link('/etc/nginx/sites-enabled/pybaseball')
        .with_to('/etc/nginx/sites-available/pybaseball')
    end

    it 'starts and enables the systemd service' do
      expect(chef_run).to enable_service('pybaseball')

      expect(chef_run).to start_service('pybaseball')
    end

    it 'restarts the nginx service' do
      expect(chef_run).to restart_service('nginx')
    end
end
