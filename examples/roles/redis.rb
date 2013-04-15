name "redis"
description "Redis DB Master"

run_list %w{
  recipe[sysctl]
  recipe[redis::sentinel]
  }

default_attributes(
  "sysctl" => {
    # allow linux to overcommit memory
    # see: http://redis.io/topics/faq for deets
    "set_over_commit" => {
      "vm.overcommit_memory" => 1
    }
  },
  "redis" => {
    "conf_dir" => "/etc/redis",
    "dst_dir" => "/usr",
    # old ubuntu is old. Too old packages to really want to use...
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
        }
      }
    }
  }
)