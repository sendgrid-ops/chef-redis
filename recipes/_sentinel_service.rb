#
# Cookbook Name:: redis
# Recipe:: _sentinel_service

service 'redis-sentinel' do
  action [:enable, :start]
end
