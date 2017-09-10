#
# Cookbook:: baseball_api
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'baseball_api::app' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.node.normal['app']['location'] = '/test/dir'
      runner.converge(described_recipe)
    end

  it 'should create the application directory' do
    expect(chef_run).to create_directory('/test/dir')
      .with_mode('0755')
  end

  it 'should copy the application source to the application directory' do
    expect(chef_run).to run_bash('Copy directory')
  end

  it 'should setup the Python runtime' do
  end

  it 'should create the virtual environment' do
    expect(chef_run).to create_python_virtualenv('/test/dir/.env')
  end

  it 'should install the requirements for the virtual environment' do
      expect(chef_run).to install_pip_requirements('/test/dir/requirements.txt')
  end
end
