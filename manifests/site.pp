import 'deploy.pp'

node 'UnixServer.home' {
	
	class { 'deploy':
		vhost_name => 'UnixServer'
	}
	
}
