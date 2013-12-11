#
# Cookbook Name:: balanced-dns
# Recipe:: default
#
# Copyright 2013, Balanced
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'route53'

[
 node.name,
 "ip-#{node[:ipaddress].gsub('.', '-')}",
 node['ec2']['instance_id'],
].each do |name|

  route53_record "#{name}.vandelay.io" do

    value node[:ipaddress]
    type  'A'

    zone_id               node[:route53][:zone_id]
    aws_access_key_id     node[:citadel][:access_key_id]
    aws_secret_access_key node[:citadel][:secret_access_key]

    action :create
  end

end
