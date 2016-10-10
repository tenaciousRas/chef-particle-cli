# particle-cli Cookbook

Installs particle-cli from a pre-built binary and related libraries.  Based on chef-particle-base, but more atomic.  Does not use NPM to install particle-cli, but support can be added for that install method, as well as particle-cli-wrapper.

Not tested on RPi.

## Requirements

### Platforms
- Debian/Ubuntu
- Mac OS X
- Windows?

### Chef
- Chef 12.0+

### Cookbooks
- apt -- needed for lib32c packages
- git -- needed for particle firmware repo. and other libraries

## Attributes
Customize the attributes to suit site specific conventions and defaults.
- `node['particle_cli']['dir']` - user to use for install.  defaults to /home/[user]/particle.
- `node['particle_cli']['directories']['tmp']` - location of tmp folder to use for cookbook activities.


### particle-cli::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><span style="font-family: monospace;">['particle_cli']['user']</span></td>
    <td>String</td>
    <td>User name used for install.  The binary package will be given these user permissions and placed under this users home directory.</td>
    <td><span style="font-family: monospace;">vagrant</span></td>
  </tr>
  <tr>
    <td><span style="font-family: monospace;">['particle_cli']['group']</span></td>
    <td>String</td>
    <td>Group to use for install.</td>
    <td><span style="font-family: monospace;">vagrant</span></td>
  </tr>
  <tr>
    <td><span style="font-family: monospace;">['particle_cli']['dir']</span></td>
    <td>String</td>
    <td>Directory to place particle_cli_embedded downloads/binaries/sources.</td>
    <td><span style="font-family: monospace;">/home/#{node['particle_cli']['user']}/particle</span></td>
  </tr>
  <tr>
    <td><span style="font-family: monospace;">['particle_cli']['directories']['tmp']</span></td>
    <td>String</td>
    <td>tmp folder for cookbook-related activities</td>
    <td><span style="font-family: monospace;">#{node['particle_cli']['dir']}/tmp</span></td>
  </tr>
  <tr>
    <td><span style="font-family: monospace;">['particle_cli']['directories']['bin']</span></td>
    <td>String</td>
    <td>bin folder for cookbook-related activities</td>
    <td><span style="font-family: monospace;">#{node['particle_cli']['dir']}/bin</span></td>
  </tr>
</table>

### particle-cli::particle_cli

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><span style="font-family: monospace;">['particle_cli']['source_url']</span></td>
    <td>String</td>
    <td>URL that serves the particle_cli prebuilt binary.</td>
    <td><span style="font-family: monospace;">if platform_family?('mac_os_x')
  "https://dfu55fst9l042.cloudfront.net/master/0.0.1-dedbf1f/darwin/amd64/particle-cli-ng.gz"
elsif platform_family?('debian')
  "https://dfu55fst9l042.cloudfront.net/master/0.0.1-dedbf1f/linux/amd64/particle-cli-ng.gz"
elsif platform_family?('windows')
  "https://dfu55fst9l042.cloudfront.net/master/0.0.1-dedbf1f/windows/amd64/particle-cli-ng.exe"</span></td>
  </tr>
  <tr>
    <td><span style="font-family: monospace;">['particle_cli'] -- there are more attrs</span></td>
    <td>n/a</td>
    <td>...</td>
    <td><span style="font-family: monospace;">...</span></td>
  </tr>
</table>

## Resources
Not currently defined.

## Actions
- `:create`: Downloads a particle-cli prebuilt-binary and installs it.  Also downloads Particle's core firmware, core common, and core communication libraries.  Creates a friendly-symlink for compiling Particle firmware with gcc-arm-embedded.


## Usage

### particle-cli::default

Just include `particle-cli` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[particle-cli]"
  ]
}
```

## Examples

Install particle-cli in non-default folder with non-default user.
```ruby
 particle-cli do
   user 'my-user'
   group 'my-group'
   action :create
 end
```

Install particle-cli in default folder for default user with non-default binary version.
```ruby
 particle-cli do
   source_url 'https://dfu55fst9l042.cloudfront.net/master/0.0.1-dedbf1f/darwin/amd64/particle-cli-ng.gz'
   action :create
 end
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License & Authors
- Author: Free Beachler, Longevity Software LLC, ([longevitysoft@gmail.com](mailto:longevitysoft@gmail.com))
- Copyright: 2016, Free Beachler

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

