#
# Cookbook Name:: particle-cli
# Recipe:: install_particle_cli
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
###
# Installs particle-cli via a pre-cooked binary package Julien created
###

new_dirs = ["#{node['particle_cli']['dir']}", "#{node['particle_cli']['directories']['bin']}", "#{node['particle_cli']['directories']['tmp']}"]
new_dirs.each do |dir|
  directory "#{dir}" do
    owner node['particle_cli']['user']
    group node['particle_cli']['group']
    mode '0755'
    recursive true
    action :create
  end
end

# download installer
remote_file node['particle_cli']['download_path'] do
  source node['particle_cli']['source_url']
  not_if { File.exists?(node['particle_cli']['download_path']) }
end

if platform_family?('windows')
  Chef::Log.info "particle_cli not unzipping, expecting an .exe on #{node['platform_family']}"
  log "particle_cli not unzipping, expecting an .exe on #{node['platform_family']}"
else
  execute "change particle-cli-ng permissions" do
    command "chmod 755 #{node['particle_cli']['executable_path']}"
    action :nothing
  end
  execute 'gunzip particle-cli-ng installer' do
    command "gunzip #{node['particle_cli']['download_path']}"
    cwd node['particle_cli']['working_dir']
    not_if { File.exists?(node['particle_cli']['executable_path']) }
    notifies :run, "execute[change particle-cli-ng permissions]", :immediately
  end
end
execute 'install particle-cli from particle-cli-ng' do
  environment({"HOME" => node['particle_cli']['home_dir']})
  command "./#{node['particle_cli']['executable_name']}"
  cwd node['particle_cli']['working_dir']
  returns [0,1]
  not_if { File.exists?("#{node['particle_cli']['home_dir']}/.particle") }
  only_if { File.exists?(node['particle_cli']['executable_path']) }
end

# TODO: /Users/particle-ci/.particle/node-v5.4.1-darwin-x64 needs to be loaded into the path from the installer
# can get same result with NVM cookbook
link "/usr/local/bin/particle" do
  to "#{node['particle_cli']['home_dir']}/.particle/node_modules/particle-cli/bin/particle.js"
end
