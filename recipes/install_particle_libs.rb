#
# Cookbook Name:: particle-cli
# Recipe:: install_particle_libs
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
# installs particle core-firmware, particle core-communication-lib,
# particle and core-common-lib

# mkdir $HOME/particle
# cd $HOME/particle
# git clone https://www.github.com/spark/core-communication-lib.git
# git clone https://www.github.com/spark/core-firmware.git
# git clone https://www.github.com/spark/core-common-lib.git
# sudo apt-get install libarchive-zip-perl
# cd ~/particle/core-firmware
# git checkout master
# PATH=~/bin/gcc-arm-embedded/gcc-arm-none-eabi-5_4-2016q2/bin/:$PATH && make
# echo $?
##0

include_recipe('git')
include_recipe('apt')

package 'Install particle-cli Dependencies' do
  case node[:platform]
  when 'redhat', 'centos', 'debian'
  when 'ubuntu', 'linuxmint'
    package_name 'libarchive-zip-perl'
  end
end

directory "#{node['particle_cli']['dir']}" do
  user node['particle_cli']['user']
  group node['particle_cli']['group']
  action :create
end

git "#{node['particle_cli']['dir']}/communication_lib" do
  user node['particle_cli']['user']
  group node['particle_cli']['group']
  repository node['particle_cli']['communication_lib']['repo_url']
  reference node['particle_cli']['communication_lib']['repo_ref']
  timeout 5
  retries 2
  retry_delay 2
  action :sync
end

git "#{node['particle_cli']['dir']}/core_fw" do
  user node['particle_cli']['user']
  group node['particle_cli']['group']
  repository node['particle_cli']['core_fw']['repo_url']
  reference node['particle_cli']['core_fw']['repo_ref']
  timeout 5
  retries 2
  retry_delay 2
  action :sync
end

template "#{node['particle_cli']['home_dir']}/particle_fw_make_all.sh" do
  source 'particle_fw_make_all.sh.erb'
  mode 0755
  cookbook "particle-cli"
  variables ({
    :particle_fw_make_path => node['particle_cli']['particle_fw_make_path'],
    :particle_cli_dir => node['particle_cli']['dir']
  })
end

git "#{node['particle_cli']['dir']}/core_common_lib" do
  user node['particle_cli']['user']
  group node['particle_cli']['group']
  repository node['particle_cli']['core_common_lib']['repo_url']
  reference node['particle_cli']['core_common_lib']['repo_ref']
  timeout 5
  retries 2
  retry_delay 2
  action :sync
end
