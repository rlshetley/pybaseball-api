#
# Cookbook:: baseball_api
# Recipe:: database
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Install and start MySQL service
mysql_service 'db' do
  port '3306'
  version '5.7'
  initial_root_password 'change_me'
  action [:create, :start]
end

# Install the MySQL client so we can execute SQL
mysql_client 'default' do
  action :create
end

# Download and unzip the SQL data scripts
remote_file '/tmp/baseball_sql.zip' do
  source 'http://seanlahman.com/files/database/lahman2016-sql.zip'
end

directory '/tmp/sql' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

zipfile '/tmp/baseball_sql.zip' do
  into '/tmp/sql'
end

cookbook_file '/tmp/sql/AddPrimaryKey.sql' do
  source 'AddPrimaryKey.sql'
  action :create
end

# Execute the SQL scripts to build the database
execute 'Run_SQL_Files' do
  command 'mysql -S /var/run/mysql-db/mysqld.sock --user=root --password=change_me < /tmp/sql/lahman2016.sql'
end

# Need a primary key added to all tables to ensure that we can databind with SQL Alchemy
execute 'Add_Primary_Key' do
  command 'mysql -S /var/run/mysql-db/mysqld.sock --user=root --password=change_me lahman2016 < /tmp/sql/AddPrimaryKey.sql'
end
