# This tag will be appended to the iso filename.
tag 'chef-0.7.10'

repositories [
  'http://us.archive.ubuntu.com/ubuntu jaunty main restricted universe'
]

tasks         ['minimal', 'standard', 'server', 'openssh-server', 'lamp-server', 'mail-server', 'samba-server']

# These packages (and their dependencies) will be included in the ISO image.
include_packages [
  # These guys are necessary to make it through the installation process.
  'linux-server', 'language-support-en', 'grub',
  # And we want these:
  'alpine',
  'apache2-prefork-dev',
  'fetchmail',
  'git-core', 'gitk', 'git-svn', 'git-email',
  'libmysqlclient15-dev', 'mysql-client',
  'mailutils',
  'mgetty',
  'mrtg',
  'postfix-mysql',
  'rsnapshot',
  'squid',
  'twm',
  'vnc4server',
  'xinetd',
  'xterm'
]

# These packages will be included in the ISO image *and* installed at the end
# of the installation process.
install_packages [
  # I'll always want ssh access:
  'openssh-server',
  # And ruby, of course:
  'ruby', 'libopenssl-ruby',
  # These are nice when we're working with ruby:
  'rdoc', 'ri', 'irb',
  # These are nice if we install any gems with C extensions:
  'ruby-dev', 'build-essential'
]

post_install_commands [
  # Install Rubygems from source:
  "in-target sh -c 'cd /tmp; tar zxf /cdrom/bundle/rubygems-1.3.5.tgz; cd rubygems-1.3.5; ruby setup.rb; ln -sfv /usr/bin/gem1.8 /usr/bin/gem'",
  # Copy over gems directory:
  "in-target sh -c 'cp -r /cdrom/bundle/rubygems /usr/local; /bin/echo -e \"---\\n:sources: \\n- file:/usr/local/rubygems/\\n\" > /etc/gemrc'",
  # Install chef and chef-deploy gems:
  "in-target sh -c 'gem install chef        --no-rdoc --no-ri'",
  "in-target sh -c 'gem install chef-deploy --no-rdoc --no-ri'",
  # Copy over a handy Bootstrap script:
  "in-target sh -c 'cp /cdrom/bundle/bootstrap.rb /root/bootstrap'"
]
