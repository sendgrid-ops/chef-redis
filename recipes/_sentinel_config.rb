#
# Cookbook Name:: redis
# Recipe:: _sentinel_config

# if redis::_server_config and redis::_sentinel_config are on the same
# server, they'll fight over who gets to manage node['redis']['conf_dir'].
# This avoids that in a hopefully not completely insane way.
directory 'redis-conf' do
  path node['redis']['conf_dir']
  owner 'root'
  group 'root'
  mode 0755
end

template "#{node['redis']['conf_dir']}/sentinel.conf" do
  source 'sentinel.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables node['redis']['config']['sentinel']
  notifies :restart, 'service[redis-sentinel]', :delayed
end
