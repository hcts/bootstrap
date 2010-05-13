require 'captain'

Captain::Rake::ISO.new(:default) do |task|
  task.tag = 'chef-0.7.8'

  task.repositories = [
    'http://us.archive.ubuntu.com/ubuntu jaunty main restricted universe'
  ]

  task.tasks = %w(
    minimal
    standard
    server
    openssh-server
    lamp-server
    mail-server
    samba-server
  )

  task.include_packages = %w(
    alpine
    apache2-prefork-dev
    fetchmail
    git-core gitk git-svn git-email
    libapache2-mod-auth-pam
    libmysqlclient15-dev mysql-client
    mailutils
    mgetty
    mrtg
    postfix-mysql
    rrdtool
    rsnapshot
    squid
    vnc4server
    xfce4-cpugraph-plugin
    xfce4-netload-plugin
    xfce4-systemload-plugin
    xfce4-terminal
    xrdp
    xubuntu-desktop
  )

  task.install_packages = %w(
    openssh-server
    ruby libopenssl-ruby rdoc ri irb ruby-dev build-essential
    git-core vim
  )

  task.post_install_commands = [
    'in-target sh -c /cdrom/bundle/scripts/install_rubygems',
    'in-target sh -c /cdrom/bundle/scripts/install_chef'
  ]

  Captain::Rake::VMware.new do |vm|
    vm.iso_image = task.iso_image_path
  end
end

# FIXME if you look at `rake -P`, you'll see these prerequisites happen too
# late. I need to fix captain. For now, just run `rake rubygems` before running
# `rake default`. Sigh.
task :default => :rubygems

task :rubygems => %w(
  bundle/rubygems-1.3.5
  bundle/rubygems/latest_specs.4.8
)

# oddly, the gunzip in jaunty isn't handling this file, though I've confirmed
# it's reproduced with the same md5sum and I can extract it locally. No matter,
# I'll just extract it before putting it on disk.
file 'bundle/rubygems-1.3.5' => 'bundle/rubygems-1.3.5.tgz' do
  chdir('bundle') { sh 'tar zxf rubygems-1.3.5.tgz' }
end

file 'bundle/rubygems-1.3.5.tgz' do |task|
  sh "curl --location --output #{task.name} http://rubyforge.org/frs/download.php/60718/rubygems-1.3.5.tgz"
end

file 'bundle/rubygems/latest_specs.4.8' => 'Gemfile' do
  sh 'rm -rf bundle/rubygems'
  sh 'mkdir bundle/rubygems'
  sh 'bundle pack'
  sh 'mv vendor/cache bundle/rubygems/gems'
  sh 'rm -rf vendor'
  sh 'gem generate_index --directory bundle/rubygems --no-legacy'
end
