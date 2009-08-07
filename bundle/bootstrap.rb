#!/usr/bin/env ruby

unless ENV.has_key?('SERVER')
  ENV['SERVER']        = 'http://10.0.1.2:4000'
  ENV['OPENID_SERVER'] = 'http://10.0.1.2:4001'
end

# I decided, on-balance, not to use a validation token here, since I'd like to
# pre-configure all the recipes for the node in the chef-server (from home)
# before running the bootstrapping process. (I'd like the node's configuration
# to include the chef::client recipe, but that would result in a race between
# 2 chef clients, bootstrap & runit, for the dpkg lock.) So, as a simple
# not-too-painful workaround, I'll just need to manually validate the node's
# registration in the web ui after bootstrapping.
system 'mount /media/cdrom0'
system 'chef-solo --config /cdrom/bundle/solo.rb --json-attributes /cdrom/bundle/solo.json'

puts
puts 'Bootstrapping done.'
puts "Now, let's tail the real chef-client log:"
exec 'tail -f /etc/sv/chef-client/log/main/current'
