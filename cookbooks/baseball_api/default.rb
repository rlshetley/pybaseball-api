default['app']['location'] = '/opt/baseball_api/'
default['app']['virtualenv'] = '#{node[:app][:location]}/.env'
default['app']['ini'] = ''
default['app']['user']='pybaseball'
default['app']['group']='www-data'
