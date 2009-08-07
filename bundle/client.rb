registration_url ENV['SERVER']
openid_url       ENV['OPENID_SERVER'] || ENV['SERVER']
template_url     ENV['SERVER']
remotefile_url   ENV['SERVER']
search_url       ENV['SERVER']
role_url         ENV['SERVER']

# Using the "real" values here instead of /tmp/chef-client means I won't lose
# my registration token.
#
# Of course, this is a little hinky. Perhaps a better way would be to use
# chef-solo to bootstrap with a tarball of recipes from the server, but as far
# as I know now, chef-server doesn't automatically support sending such a
# tarball, so I'd have to add it. Right?
#
# (I can't use the standard bootstrap-latest.tar.gz because it assumes https,
# which I'm not using in development, and because it doesn't have great
# support for http basic auth.)
file_store_path  '/srv/chef/file_store'
file_cache_path  '/srv/chef/cache'
