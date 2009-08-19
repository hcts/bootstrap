#!/usr/bin/env ruby

unless ENV.has_key?('SERVER')
  ENV['SERVER']        = 'http://192.168.42.1:4000'
  ENV['OPENID_SERVER'] = 'http://192.168.42.1:4001'
end

ENV['TOKEN'] ||= 'foo'

raise unless system 'mount /media/cdrom0'
raise unless system 'chef-solo --config /cdrom/bundle/solo.rb --json-attributes /cdrom/bundle/solo.json'

puts
puts 'Bootstrapping done.'
puts 'Running chef-client for the first time:'
system "chef-client --token #{ENV['TOKEN']}"

puts
puts 'Uncomment /etc/cron.d/chef-client to schedule regular chef-client runs.'
