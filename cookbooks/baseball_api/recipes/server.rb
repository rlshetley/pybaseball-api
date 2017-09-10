#
# Cookbook:: baseball_api
# Recipe:: server
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe "chef_nginx::default"

template "#{node[:app][:location]}/pybaseball.ini"  do
  source "app.ini.erb"
end

template "/etc/systemd/system/pybaseball.service"  do
  source "app.service.erb"
end

template "/etc/nginx/sites-available/pybaseball"  do
  source "nginx.site.erb"
end

link "/etc/nginx/sites-enabled/pybaseball" do
  to "/etc/nginx/sites-available/pybaseball"
end

service "pybaseball" do
  action [:enable, :start]
end

service "nginx" do
  action [:restart]
end
