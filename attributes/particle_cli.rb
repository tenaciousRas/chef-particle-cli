#
# Cookbook Name:: particle-cli
# Attributes:: particle_cli
#
# Copyright 2016, Free Beachler, Longevity Software LLC
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
###
# install_particle_cli template, etc., require home directory to be specified
default['particle_cli']['home_dir'] = "/home/#{node['particle_cli']['user']}/"
# for handy bash wrapper scripts, for tools that install via curl/wget; you can use remote_file to render the file into here, then execute it
default['particle_cli']['directories']['bin'] = "#{node['particle_cli']['dir']}/bin"
# for tmp files that should NOT be managed by the OS's tmp folder
default['particle_cli']['directories']['tmp'] = "#{node['particle_cli']['dir']}/tmp"

default['particle_cli']['source_url'] = if platform_family?('mac_os_x')
  "https://dfu55fst9l042.cloudfront.net/master/0.0.1-dedbf1f/darwin/amd64/particle-cli-ng.gz"
elsif platform_family?('debian')
  "https://dfu55fst9l042.cloudfront.net/master/0.0.1-dedbf1f/linux/amd64/particle-cli-ng.gz"
elsif platform_family?('windows')
  "https://dfu55fst9l042.cloudfront.net/master/0.0.1-dedbf1f/windows/amd64/particle-cli-ng.exe"
else
  Chef::Log.error "particle_cli not supported on #{node['platform_family']}"
  "" # return a string;
end

default['particle_cli']['download_path'] = "#{node['particle_cli']['directories']['tmp']}/#{File.basename(node['particle_cli']['source_url'])}"
default['particle_cli']['executable_name'] = if platform_family?('windows')
  'particle-cli-ng.exe'
else
  'particle-cli-ng'
end
default['particle_cli']['working_dir'] = File.dirname(node['particle_cli']['download_path'])
default['particle_cli']['executable_path'] = "#{node['particle_cli']['working_dir']}/#{node['particle_cli']['executable_name']}"
