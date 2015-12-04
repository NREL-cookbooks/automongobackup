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
  source "https://raw.githubusercontent.com/david-harrison/automongobackup/ac15a1760e32bf482ea1b660d99d1a701ac04bac/src/automongobackup.sh"
  checksum "b18f53584add3a7758c155c345f47f231248f6b3d969d7ff2e7a695376e3fce4"
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
