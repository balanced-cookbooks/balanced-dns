#
# Cookbook Name:: balanced-dns
# Recipe:: default
#
# Copyright 2013, Balanced
#
# All rights reserved - Do Not Redistribute
#

# need otherwise fog warns
chef_gem 'unf'
  options "--no-ri --no-rdoc"
  action :nothing
end.run_action(:install)

include_recipe 'route53'

if node['ec2']
  [
   node.name,
   "ip-#{node[:ipaddress].gsub('.', '-')}",
   node['ec2']['instance_id'],
  ].each do |name|
  
    route53_record "#{name}.vandelay.io" do
  
      value node[:ipaddress]
      type  'A'
  
      zone_id               node[:route53][:zone_id]
      aws_access_key_id     citadel.access_key_id
      aws_secret_access_key citadel.secret_access_key
      aws_session_token     citadel.token
  
      action :create
    end
  
  end
end
