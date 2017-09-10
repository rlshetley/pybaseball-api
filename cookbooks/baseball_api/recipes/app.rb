#
# Cookbook:: baseball_api
# Recipe:: app
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Create the directory to run the app from

include_recipe "poise-python"

directory node[:app][:location] do
  mode "0755"
  action :create
end

bash "Copy directory" do
  code <<-EOL
  cp -R /vagrant/src/. #{node[:app][:location]}
  EOL
end

# Setup Python environment
python_virtualenv "#{node[:app][:location]}/.env"

pip_requirements "#{node[:app][:location]}/requirements.txt" do
  virtualenv "#{node[:app][:location]}/.env"
end
