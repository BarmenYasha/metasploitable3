#
# Cookbook:: metasploitable
# Recipe:: flags
#
# Copyright:: 2018, Rapid7, All Rights Reserved.

docker_service 'default' do
  action [:create, :start]
  group 'docker'
end

remote_directory "/opt/flags" do
  source 'flags_2018'
  files_owner 'root'
  files_group 'root'
  files_mode '0755'
  action :create
  recursive true
end

dpkg_package 'linux-image-generic'
dpkg_package 'alsa-utils'
dpkg_package 'build-essential'
dpkg_package 'libasound-dev'

execute 'build sound server' do
  cwd '/opt/flags/king_of_diamonds/src'
  command 'make'
  live_stream true
end

execute 'build and deploy flags' do
  cwd '/opt/flags'
  command './build.sh --persist'
  live_stream true
end
