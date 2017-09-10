#
# Cookbook:: baseball_api
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Install dependencies needed for application to work
apt_package 'libmysqlclient-dev'
apt_package 'python-mysqldb'
apt_package 'build-essential'
apt_package 'python-dev'
apt_package 'zlib1g-dev'
apt_package 'libssl-dev'

# Execute recipes
include_recipe 'baseball_api::app'
include_recipe 'baseball_api::server'
include_recipe 'baseball_api::database'
