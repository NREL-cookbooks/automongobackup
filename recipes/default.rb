#
# Cookbook Name:: automongobackup
# Recipe:: default
#
# Copyright 2014, NREL
#
# All rights reserved - Do Not Redistribute
#

include_recipe "cron"

# Setting MAILCONTENT=quiet doesn't seem to currently work:
# https://github.com/micahwedemeyer/automongobackup/issues/17
# For now use cronic to prevent chatty output.
include_recipe "cron::cronic"

if platform_family?("rhel")
  template "/etc/sysconfig/automongobackup" do
    source "sysconfig.erb"
    owner "root"
    group "root"
    mode "0644"
  end
end

remote_file "/usr/local/bin/automongobackup" do
  source "https://raw.githubusercontent.com/david-harrison/automongobackup/99e5808efdf8512e1423704d423c928b38ec858d/src/automongobackup.sh"
  checksum "c0367c8c60ba83072cf12932aa063485935fd8fa22bbe5a2a9c9e54706b047b0"
  owner "root"
  group "root"
  mode "0755"
end

template "/etc/cron.d/automongobackup" do
  source "cron.erb"
  mode "0644"
  owner "root"
  group "root"
end
