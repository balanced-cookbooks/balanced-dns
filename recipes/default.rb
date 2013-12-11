#
# Cookbook Name:: balanced-hostname
# Recipe:: default
#
# Copyright 2013, Balanced
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'balanced-hostname::setup_hostname'

# lame, need to refresh apt first
include_recipe 'apt'
include_recipe 'route53'


route53_record "#{node.name}.vandelay.io" do

  value node[:ipaddress]
  type  "CNAME"

  zone_id               node[:route53][:zone_id]
  aws_access_key_id     node[:citadel][:access_key_id]
  aws_secret_access_key node[:citadel][:secret_access_key]

  action :create
end
