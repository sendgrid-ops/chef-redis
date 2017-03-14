#
# Cookbook Name:: redis
# Recipe:: _sentinel_init

template 'sentinel_init' do
  path '/etc/init.d/redis-sentinel'
  variables(
    listen_port: node['redis']['config']['sentinel']['port'],
    dst_dir: node['redis']['dst_dir'],
    pid_file: node['redis']['config']['sentinel']['pidfile'],
    conf_dir: node['redis']['conf_dir'],
    conf_file: 'sentinel.conf',
    options: ' --sentinel',
    sentinel: true
  )
  source 'redis_init.erb'
  owner 'root'
  group 'root'
  mode 0755
end

include_recipe 'redis::_sentinel_service'
