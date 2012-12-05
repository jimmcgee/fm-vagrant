class linux_common {
	exec { "apt-update":
	    command => "/usr/bin/apt-get update"
	}
	# Require apt-update for every Package command
	Exec["apt-update"] -> Package <| |>

	package { make:
		ensure => installed,
	}

	package { postfix:
		ensure => installed,
	}

	file { "/etc/postfix/main.cf":
		ensure => "file",
		replace => true,
		content => "myhostname = ${fqdn}
inet_interfaces = loopback-only
local_transport = error:local delivery is disabled",
		require => Package['postfix']
	}

	package { 'libxml-xpath-perl':
		ensure => installed
	}

	package { 'unzip':
		ensure => installed
	}
}