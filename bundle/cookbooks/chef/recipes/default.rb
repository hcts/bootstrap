package 'chef'

service 'chef-client'

template '/etc/chef/client.rb' do
  source 'client.rb.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, resources(:service => 'chef-client')
end
