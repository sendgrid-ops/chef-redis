name "redis-sentinel"
description "Installs the sentinel redis monitoring service to automatically promote a slave when a redis master fails."

run_list %w{
  recipe[redis::sentinel]
  }

default_attributes(
  "redis" => {
    "conf_dir" => "/etc/redis",
    "dst_dir" => "/usr",
    # old ubuntu is old. Packages are too old to really want to use...
    "install_type" => "source",
    "source" => {
      "url" => "http://redis.googlecode.com/files/",
      "sha" => "7c8ac91c2607ae61e2b50a9a7df25120af6df364",
      "version" => "2.6.10"
    },
    "config" => {
      "sentinel" => {
        "masters" => {
          "master1" => {
            "port" => 6379,
            "ip" => "192.168.100.1",
            "quorum" => 5,
            "down_after_milliseconds" => 1500,
            "can_failover" => "yes",
            "parallel_syncs" => 2,
            "failover_timeout" => 700000,
          },
          
          "master2" => {
            "port" => 6379,
            "ip" => "192.168.100.21",
            "quorum" => 5,
            "down_after_milliseconds" => 1500,
            "can_failover" => "yes",
            "parallel_syncs" => 2,
            "failover_timeout" => 700000,
          },
          
          "master3" => {
            "port" => 6379,
            "ip" => "192.168.100.31",
            "quorum" => 5,
            "down_after_milliseconds" => 1500,
            "can_failover" => "yes",
            "parallel_syncs" => 2,
            "failover_timeout" => 700000,
          },
          
          "master4" => {
            "port" => 6379,
            "ip" => "192.168.100.41",
            "quorum" => 5,
            "down_after_milliseconds" => 1500,
            "can_failover" => "yes",
            "parallel_syncs" => 2,
            "failover_timeout" => 700000,
          },
          
          "master5" => {
            "port" => 6379,
            "ip" => "192.168.100.51",
            "quorum" => 5,
            "down_after_milliseconds" => 1500,
            "can_failover" => "yes",
            "parallel_syncs" => 2,
            "failover_timeout" => 700000,
          },
        }
      }
    }
  }
)