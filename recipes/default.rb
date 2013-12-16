#
# Author:: Matthew Francis-Landau <mathew@balancedpayments.com>
# Author:: Andrew Imam <andrew@balancedpayments.com>
# Author:: Noah Kantrowitz <noah@coderanger.net>
#
# Copyright 2013, Balanced, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Don't run this unless its a Real Server™
return if Chef::Config[:solo] || !node['ec2']

# need otherwise fog warns
chef_gem 'unf' do
  options "--no-ri --no-rdoc"
end

include_recipe 'route53'

[
 node.name,
 "ip-#{node[:ipaddress].gsub('.', '-')}",
 node['ec2']['instance_id'],
].each do |name|

  route53_record "#{name}.vandelay.io" do

    value node['ipaddress']
    type 'A'
    ttl 60

    zone_id node[:route53][:zone_id]
    aws_access_key_id citadel.access_key_id
    aws_secret_access_key citadel.secret_access_key
    aws_session_token citadel.token

    action :create
  end

end

