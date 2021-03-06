#
# Cookbook Name:: particle-cli
# Recipe:: default
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

# install nvm
include_recipe 'nvm'

nvm_install '5.12'  do
  from_source false
  alias_as_default true
  action :create
end

# install particle-cli via a pre-cooked binary package
# install particle firmware and libs

include_recipe('particle-cli::install_particle_cli')
include_recipe('particle-cli::install_particle_libs')
