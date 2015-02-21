class deploy ( $vhost_name = 'localhost' ) {
	class { 'epel': }
	class { 'apache': }
	
	include apache::mod::passenger
	
	apache::vhost { $vhost_name:
	  port    => '80',
	  docroot => '/var/www/simple-sinatra-app/'
	}
	
	firewall { 'http and https acl':
	  port   => [80, 443],
	  proto  => tcp,
	  action => accept,
	}
	
	package { 'sinatra':
		ensure => 'installed',
		provider => 'gem'
	}
	
	package { 'bundler':
		ensure => 'installed',
		provider => 'gem'
	} 
	
	file { "/var/www":
		ensure => 'directory'
	}
	
	file { "/var/www/simple-sinatra-app":
		ensure => 'directory'
	}
	
	file { "/var/www/simple-sinatra-app/tmp":
		ensure => 'directory'
	}
	
	package { 'git':
		ensure => 'installed'
	}
	
	vcsrepo { "/var/www/simple-sinatra-app":
		ensure => 'present',
		provider => 'git',
		source => "https://github.com/tnh/simple-sinatra-app.git"
	}

	exec { "apache_own_www":
		command => "chown -R apache /var/www",
		path    => "/usr/local/bin/:/bin/"
	}

}
