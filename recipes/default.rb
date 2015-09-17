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
  source "https://raw.githubusercontent.com/david-harrison/automongobackup/600d36050c84c442ba99e6450457040bc0b7a2ef/src/automongobackup.sh"
  checksum "897148bb9193e863c5a0db3867b1098a6bc486cff9b1536449794519fd86af5d"
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
