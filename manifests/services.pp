define ircd::services {
  require ircd
  # TODO Not functional
  package { "ircservices":
    name   => "unreal",
    ensure => "present",
  }
  file { "ircservices.conf":
    path    => "/usr/local/etc/ircservices.conf",
    content => template("modules/ircservices.conf.erb"),
    require => Package['ircservices'],
    before  => Service["ircservices"],
  }
  file { "modules.conf":
    path    => "/usr/local/etc/modules.conf",
    content => template("modules/modules.conf.erb"),
    require => Package['ircservices'],
    before  => Service["ircservices"],
  }
  service { "ircservices":
    ensure  => "running",
    enable  => true,
  }
}
