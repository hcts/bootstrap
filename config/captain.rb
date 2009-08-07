# This tag will be appended to the iso filename, to help me remember.
tag 'chef-0.7.4'

repositories  ['http://us.archive.ubuntu.com/ubuntu jaunty main restricted universe']
tasks         ['minimal', 'standard', 'server', 'openssh-server', 'lamp-server', 'mail-server', 'samba-server']

# These packages (and their dependencies) will be included in the ISO image.
include_packages [
  # These guys are necessary to make it through the installation process.
  'linux-server', 'language-support-en', 'grub',
  # The chef::client recipe configures chef-client to run under runit.
  'runit',
  # And we want these:
  'git-core', 'gitk', 'git-svn', 'git-email',
  'libmysqlclient15-dev', 'mysql-client',
  'apache2-prefork-dev'
]

# These packages will be included in the ISO image *and* installed at the end
# of the installation process.
install_packages [
  # These are roughly the packages mentioned at
  # http://wiki.opscode.com/pages/viewpage.action?pageId=2457665 for
  # bootstrapping a chef client. I've removed the 1.8 version suffixes so
  # we'll depend on the default provided packages. I've also excluded wget
  # (since we install rubygems as a package, below) and ssl-cert (since we
  # won't need to generate any certificates).
  'ruby', 'ruby-dev', 'libopenssl-ruby', 'rdoc', 'ri', 'irb', 'build-essential'
]

post_install_commands [
  # Here we take advantage of the fact that captain automatically includes the
  # bundle directory in the ISO image.
  "in-target sh -c 'cd /tmp; tar zxf /cdrom/bundle/rubygems-1.3.5.tgz; cd rubygems-1.3.5; ruby setup.rb; ln -sfv /usr/bin/gem1.8 /usr/bin/gem'",
  "in-target sh -c 'cd /cdrom/bundle/gems; gem install chef-0.7.4.gem        --local --no-rdoc --no-ri'",
  "in-target sh -c 'cd /cdrom/bundle/gems; gem install chef-deploy-0.2.3.gem --local --no-rdoc --no-ri'",
  "in-target sh -c 'cp /cdrom/bundle/bootstrap.rb /root/bootstrap'"
]
