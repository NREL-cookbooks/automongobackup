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
  source "https://raw.github.com/micahwedemeyer/automongobackup/7bc8b068fa75c970234b2b8b9843acaadfa52ac8/src/automongobackup.sh"
  checksum "224ae4b8798e84ba35a48f2ae5acf7b3f97261c68562c80daeeb8f082c76e3db"
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
