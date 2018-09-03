#
# Cookbook:: node-exporter-installer
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

file_path = '/tmp/node-exporter-install.sh'

cookbook_file file_path do
  source 'node-exporter-install.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute 'run' do
  command file_path
  action :run
end
