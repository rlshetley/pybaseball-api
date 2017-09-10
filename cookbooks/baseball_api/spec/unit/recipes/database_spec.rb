#
# Cookbook:: baseball_api
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'baseball_api::database' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'should create the MySQL service' do
      expect(chef_run).to create_mysql_service('db')
        .with_port('3306')
        .with_version('5.7')
        .with_initial_root_password('change_me')
    end

    it 'should start the MySQL service' do
      expect(chef_run).to start_mysql_service('db')
    end

    it 'should create the MySQL client' do
      expect(chef_run).to create_mysql_client('default')
    end

    it 'should download the SQL script zip file' do
      expect(chef_run).to create_remote_file('/tmp/baseball_sql.zip')
        .with_source('http://seanlahman.com/files/database/lahman2016-sql.zip')
    end

    it 'should create a temp SQL directory' do
      expect(chef_run).to create_directory('/tmp/sql')
        .with_owner('root')
        .with_group('root')
    end

    it 'should unzip the SQL script zip file' do
      expect(chef_run).to extract_zipfile('/tmp/baseball_sql.zip')
        .with_into('/tmp/sql')
    end

    it 'should execute the SQL scripts' do
      expect(chef_run).to run_execute('Run_SQL_Files')
        .with_command('mysql -S /var/run/mysql-db/mysqld.sock --user=root --password=change_me < /tmp/sql/lahman2016.sql')
    end

    it 'should add primary keys' do
      expect(chef_run).to run_execute('Add_Primary_Key')
        .with_command('mysql -S /var/run/mysql-db/mysqld.sock --user=root --password=change_me lahman2016 < /tmp/sql/AddPrimaryKey.sql')
    end
end
