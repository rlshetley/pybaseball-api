#
# Cookbook:: baseball_api
# Recipe:: searchEngine
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe "elasticsearch::default"


# Create a virtual environment and install the requirements
# Setup Python environment
python_virtualenv "#{node[:app][:location]}/.syncenv"

pip_requirements "#{node[:app][:location]}/requirements.txt" do
  virtualenv "#{node[:app][:location]}/.syncenv"
end

# Then execute the sync-app to copy all of our data into
# the elasticsearch instance
python_execute "#{node[:app][:location]}/sync-app.py" do
  virtualenv "#{node[:app][:location]}/.syncenv"
end

# Once done, we need to delete the temporary environment
directory "#{node[:app][:location]}/.syncenv" do
  action :delete
end
