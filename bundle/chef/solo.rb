cookbook_path ['/srv/chef/site-cookbooks', '/srv/chef/cookbooks']
json_attribs   '/etc/chef/attributes.json'

Chef::Log::Formatter.show_time = (log_location != STDOUT)
