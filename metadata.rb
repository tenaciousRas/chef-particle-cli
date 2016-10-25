name             'particle-cli'
maintainer       'Free Beachler'
maintainer_email 'longevitysoft@gmail.com'
license          'All rights reserved'
description      'Installs/Configures particle-cli'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.1'
depends          'nvm'
depends          'git'
depends          'apt'

source_url 'https://github.com/tenaciousRas/chef-particle-cli'
issues_url 'https://github.com/tenaciousRas/chef-particle-cli/issues'

chef_version '>= 12.1'
