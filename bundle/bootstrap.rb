#!/usr/bin/env ruby

unless ENV.has_key?('SERVER')
  ENV['SERVER']        = 'http://10.0.1.2:4000'
  ENV['OPENID_SERVER'] = 'http://10.0.1.2:4001'
end

ENV['TOKEN'] ||= 'foo'

log_level = ARGV.shift || 'info'

system 'mount /media/cdrom0'
system "chef-client --config /cdrom/bundle/client.rb --log_level #{log_level} --token #{ENV['TOKEN']} 2>&1 | tee bootstrap.log"
