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
  files_mode '0750'
  action :create
  recursive true
end

bash 'deploy flags' do
  code <<-EOH
    cd /opt/flags
    ./build.sh --persist
  EOH
end
