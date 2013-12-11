#
# Cookbook Name:: balanced-hostname
# Recipe:: setup_hostname
#
# Copyright (C) 2013 Balanced
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# https://github.com/ichilton/chef_fqdn_fix/blob/master/recipes/default.rb
# http://stackoverflow.com/questions/4227994/command-line-arguments-from-a-file-content
execute 'configure-hostname' do
  command "hostname #{node.name}"
  action :nothing
end

# stolen from: http://www.onepwr.org/2012/04/26/chef-recipe-to-setup-up-a-new-nodes-fqdn-hostname-etc-properly/
# Ensure the hostname of the system is set to knife provided node name
file '/etc/hostname' do
  content "#{node.name}\n"
  notifies :run, resources(:execute => 'configure-hostname'), :immediately
end

# This sets up script which will run whenever eth0 comes up(after reboot) to update /etc/hosts
cookbook_file '/etc/network/if-up.d/update_hosts' do
  source 'update_hosts.bash'
  owner 'root'
  group 'root'
  mode 0555
  backup false
end

# Execute this script now (firsttime) to set /etc/hosts to have the newly
# provisioned nodes address/hostname line

execute 'update_hosts' do
  user 'root'
  group 'root'
  cwd '/tmp'
  command <<-EOH
  export IFACE=eth0
  /etc/network/if-up.d/update_hosts
  EOH
end

# override the fqdn
node.override[:fqdn] = "#{node.name}"
