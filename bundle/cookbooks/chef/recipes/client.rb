%w[/etc/chef /var/cache/chef /var/lib/chef /var/log/chef /var/run/chef].each do |path|
  directory path do
    owner 'root'
    group 'root'
    mode 0755
  end
end

file '/var/log/chef/client.log' do
  owner 'root'
  group 'root'
  mode 0644
  action :touch
end

template '/etc/chef/client.rb' do
  source 'client.rb.erb'
  owner 'root'
  group 'root'
  mode 0644
end

template '/etc/cron.d/chef-client' do
  source 'cron-chef-client.erb'
  owner 'root'
  group 'root'
  mode 0644
end

template '/etc/logrotate.d/chef' do
  source 'logrotate-chef.erb'
  owner 'root'
  group 'root'
  mode 0644
end
