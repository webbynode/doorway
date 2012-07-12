# Doorway

Provides a sane set of utility methods to provision remote servers over SSH and SCP.

## Installation

Add this line to your application's Gemfile:

    gem 'doorway'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install doorway

## Usage

	doorway = Doorway.new(:root, "10.0.1.20", :ssh_key => "~/.keys/somekey.pem")
	
	# -or-
	
	Doorway.connect(:deployer, "10.0.1.20", :ssh_key => "~/.keys/deployer.pem") do |conn|
	
		# Raw command execution

		conn.exec    "whoami"
		conn.exec_as :root, "REALLY_GEM_UPDATE_SYSTEM=y gem update --system"
	
		# Script execution

		conn.exec_script <<-EOS.strip_heredoc
		
			#!/bin/bash
			apt-get install -y some-package
		
		EOS
		
		conn.exec_script_as :git, "scripts/add-public-ip"
		
		# Remote files

		conn.remote_file "/etc/nginx/nginx.conf", "nginx/nginx.conf"
		conn.remote_file "/etc/init.d/nginx", "nginx/nginx.init.d"
		conn.append_from "/etc/nginx/nginx.conf", "nginx/include"

		# ERB templates 
		
		conn.remote_file "/etc/nginx/conf.d/site.conf",
			:template => "nginx/vhost.conf.erb",
			:server   => "www.example.org",
			:root     => "/var/www/example"
			
		conn.append_from "/etc/sudoers.d/my_sudoers",
			:template => "sudoers/god.erb",
			:user     => "fcoury",
			:allow    => "/var/bin/all_your_base"
			
		# Download a file to server
		
		conn.get "https://webbynode_packages.s3.amazonaws.com/icecream-8.30.tar.gz", "/usr/local/src"
		  
		# Ubuntu specific package management

		conn.add_ppa "chris-lea/node.js"
		conn.install "nodejs"
	
		# Advanced commands
		
		conn.sed "/home/git/repo/.git/config", 
			/remote "github"/, 'remote "bitbucket"'
	end
	

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
