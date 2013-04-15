# you will want to (probably) override all of this in your role
# eg: role[redis-sentinel-cluster-5]

# just an example. We don't specify anything by default
#default['redis']['config']['sentinel']['masters']['localhost']['port']  = 6379
#default['redis']['config']['sentinel']['masters']['localhost']['quorum']  = 2
#default['redis']['config']['sentinel']['masters']['localhost']['down_after_milliseconds']  = 30000
#default['redis']['config']['sentinel']['masters']['localhost']['can_failover']  = "yes"
#default['redis']['config']['sentinel']['masters']['localhost']['parallel_syncs']  = 1
#default['redis']['config']['sentinel']['masters']['localhost']['failover_timeout']  = 900000

default['redis']['config']['sentinel']['pidfile'] = "/var/run/redis-sentinel.pid"
default['redis']['config']['sentinel']['daemonize'] = "yes"
default['redis']['config']['sentinel']['port'] = "26379"
default['redis']['config']['sentinel']['unixsocket'] = "/tmp/redis-sentinel.sock"
default['redis']['config']['sentinel']['unixsocketperm'] = "777" # The only way to allow apps running as other users to connect
