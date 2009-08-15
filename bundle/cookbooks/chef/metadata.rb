maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs and configures chef client and server"
version           "0.10"
recipe            "chef::client", "Sets up a client to talk to a chef-server"
depends           "runit"
supports          "ubuntu"
supports          "debian"

attribute "chef/path",
  :display_name => "Chef Path",
  :description => "Filesystem location for Chef files",
  :default => "/srv/chef"

attribute "chef/run_path",
  :display_name => "Chef Run Path",
  :description => "Filesystem location for Chef 'run' files",
  :default => "/var/run/chef"

attribute "chef/client_version",
  :display_name => "Chef Client Version",
  :description => "Set the version of the client gem to install",
  :default => "0.7.8"

attribute "chef/client_interval",
  :display_name => "Chef Client Interval ",
  :description => "Poll chef client process to run on this interval in seconds",
  :default => "1800"

attribute "chef/client_splay",
  :display_name => "Chef Client Splay ",
  :description => "Random number of seconds to add to interval",
  :default => "20"

attribute "chef/client_log",
  :display_name => "Chef Client Log",
  :description => "Location of the chef client log",
  :default => "STDOUT"
