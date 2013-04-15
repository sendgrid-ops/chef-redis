#
# Cookbook Name:: redis
# Recipe:: _server_backup


# add a backup script and friends
cookbook_file "/usr/local/bin/redis-archive" do
  source "redis-archive.sh"
  mode 0755
  owner "root"
  group "root"
end

cron "redis-archive" do
  hour "2"
  minute "10"
  command "/usr/local/bin/redis-archive"
end

# for where we store backups
directory "/var/lib/redis-archive" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end