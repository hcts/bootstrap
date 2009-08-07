#!/usr/bin/env ruby

unless ENV.has_key?('SERVER')
  ENV['SERVER']        = 'http://10.0.1.2:4000'
  ENV['OPENID_SERVER'] = 'http://10.0.1.2:4001'
end

system 'mount /media/cdrom0'
system 'chef-solo --config /cdrom/bundle/solo.rb --json-attributes /cdrom/bundle/solo.json'
