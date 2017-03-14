#
# Cookbook Name:: redis
# Recipe:: sentinel
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# you need to also include either redis::_server_install_from_source or
# redis::_server_install_from_package. You probably want source + related
# config since most Distros don't have a package that includes sentinel yet

include_recipe 'redis::_group'
include_recipe 'redis::_user'

case node['redis']['install_type']
when 'package'
  raise "Sentinel cookbook with a package install is thoroughly untested. It should work, but it's up to you to try it!"
when 'source'
  include_recipe 'redis::_server_install_from_source'
end

include_recipe 'redis::_sentinel_config'
include_recipe 'redis::_sentinel_init'
include_recipe 'redis::_sentinel_service'
