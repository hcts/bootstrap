registration_url ENV['SERVER']
openid_url       ENV['OPENID_SERVER'] || ENV['SERVER']
template_url     ENV['SERVER']
remotefile_url   ENV['SERVER']
search_url       ENV['SERVER']
role_url         ENV['SERVER']

cookbook_path    '/cdrom/bundle/cookbooks'
file_cache_path  '/tmp/chef-solo'
