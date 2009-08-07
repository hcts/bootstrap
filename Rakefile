require 'captain'
require 'erb'

ISO_FILENAME  = File.basename(Captain::Application.new.send(:iso_image_path))
VMWARE_PATH   = 'virtual_machine.vmwarevm'
VMWARE_CONFIG = File.join(VMWARE_PATH, 'virtual_machine.vmx')
VMWARE_DISK   = File.join(VMWARE_PATH, 'virtual_machine.vmdk')

directory 'bundle/gems'

rule '.gem' => 'bundle/gems' do |task|
  # FIXME gem export should honor the version number
  gem_name = File.basename(task.name, '.gem').split('-').slice(0..-2).join('-')
  sh "cd bundle/gems; gem export #{gem_name}"
end

file 'bundle/rubygems-1.3.5.tgz' do
  sh 'cd bundle; curl -L -O http://rubyforge.org/frs/download.php/60718/rubygems-1.3.5.tgz'
end

file ISO_FILENAME => FileList['config/captain.rb', 'bundle/*.rb', 'bundle/gems/chef-0.7.4.gem', 'bundle/gems/chef-deploy-0.2.3.gem', 'bundle/gems/mysql-2.7.gem', 'bundle/gems/passenger-2.2.4.gem', 'bundle/gems/rails-2.3.3.gem', 'bundle/rubygems-1.3.5.tgz'] do
  sh 'captain'
end

directory VMWARE_PATH

file VMWARE_CONFIG => [VMWARE_PATH, 'config/captain.vmx.erb'] do
  File.open(VMWARE_CONFIG, 'w') do |config|
    config.write(ERB.new(File.read('config/captain.vmx.erb')).result)
  end
end

file VMWARE_DISK => VMWARE_PATH do
  sh "vmware-vdiskmanager -c -s 2GB -a lsilogic -t 0 #{VMWARE_DISK}"
end

desc 'Build image'
task :build => ISO_FILENAME

desc 'Remove ignored files'
task :clean do
  sh 'git clean -fdX'
end

desc 'Boot image in VMware'
task :default => [:build, VMWARE_CONFIG, VMWARE_DISK] do
  sh "open #{VMWARE_PATH}"
end
