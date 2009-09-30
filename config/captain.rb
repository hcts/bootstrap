# This tag will be appended to the iso filename.
tag 'chef-0.7.8'

repositories [
  'http://us.archive.ubuntu.com/ubuntu jaunty main restricted universe'
]

tasks [
  'minimal',
  'standard',
  'server',
  'openssh-server',
  'lamp-server',
  'mail-server',
  'samba-server'
]

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
  'vnc4server',
  'xfce4-cpugraph-plugin',
  'xfce4-netload-plugin',
  'xfce4-systemload-plugin',
  'xfce4-terminal',
  'xrdp',
  'xubuntu-desktop'
]

# These packages will be included in the ISO image *and* installed at the end
# of the installation process.
install_packages [
  'openssh-server',
  'ruby', 'libopenssl-ruby', 'rdoc', 'ri', 'irb', 'ruby-dev', 'build-essential',
  'git-core', 'vim'
]

post_install_commands [
  # Install Rubygems from source:
  "in-target sh -c 'cd /tmp; tar zxf /cdrom/bundle/rubygems-1.3.5.tgz; cd rubygems-1.3.5; ruby setup.rb'",
  "in-target sh -c 'ln -sfv /usr/bin/gem1.8 /usr/bin/gem'",
  # Copy over gems directory:
  "in-target sh -c 'cp -r /cdrom/bundle/rubygems /srv'",
  "in-target sh -c '/bin/echo -e \"---\\n:sources: \\n- file:/srv/rubygems/\\n\" > /etc/gemrc'",
  # Install chef and chef-deploy gems:
  "in-target sh -c 'gem install chef        --no-rdoc --no-ri'",
  "in-target sh -c 'gem install chef-deploy --no-rdoc --no-ri'",
  # Configure chef:
  "in-target sh -c 'mkdir /etc/chef'",
  "in-target sh -c 'mkdir /var/log/chef; touch /var/log/chef/solo.log'",
  "in-target sh -c 'cp /cdrom/bundle/chef/attributes.json /etc/chef/attributes.json; chmod 600 /etc/chef/attributes.json'",
  "in-target sh -c 'cp /cdrom/bundle/chef/solo.rb         /etc/chef/solo.rb;         chmod 644 /etc/chef/solo.rb'",
  "in-target sh -c 'cp /cdrom/bundle/chef/crontab         /etc/cron.d/chef;          chmod 644 /etc/cron.d/chef'",
  "in-target sh -c 'cp /cdrom/bundle/chef/logrotate       /etc/logrotate.d/chef;     chmod 644 /etc/logrotate.d/chef'"
]
