#
# Cookbook Name:: particle-cli
# Attributes:: default
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
default['particle_cli']['install_as_root'] = false
default['particle_cli']['user'] = 'vagrant'
default['particle_cli']['group'] = 'vagrant'

# Most directories are relative to this
default['particle_cli']['dir'] = "/home/#{node['particle_cli']['user']}/.particle"

default['particle_cli']['communication_lib']['repo_url'] = "https://www.github.com/spark/core-communication-lib.git"
default['particle_cli']['communication_lib']['repo_ref'] = "master"
default['particle_cli']['core_fw']['repo_url'] = "https://www.github.com/spark/core-firmware.git"
default['particle_cli']['core_fw']['repo_ref'] = "master"
default['particle_cli']['core_common_lib']['repo_url'] = "https://www.github.com/spark/core-common-lib.git"
default['particle_cli']['core_common_lib']['repo_ref'] = "master"

default['particle_cli']['particle_fw_make_path'] = "/home/#{node['particle_cli']['user']}/gcc-arm-embedded/arm-gcc-5.4.2/bin/"
