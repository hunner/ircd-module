# Class: ircd
#
# This module manages unrealircd and it's config
#
# Parameters:
#  basedir => String (for file fragment)
#
# Actions:
#
# Requires:
#  hunner-portconf module
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class ircd ($basedir = "/tmp") {
  # basedir is the directory for the ircd.d dir of fragments

  # Location of the conf file based on operating system
  $conffile = $operatingsystem ? {
    'freebsd' => "/usr/local/etc/Unreal/unrealircd.conf",
    default   => "/etc/Unreal/unrealircd.conf",
  }

  # File fragment management resources
  file { "${basedir}/ircd.d":
    owner   => "root",
    mode    => "700",
    ensure  => "directory",
    purge   => true,
    recurse => true,
    source  => "puppet:///modules/ircd/ircd.d",
    require => Package['ircd'],
  }
  exec { "rebuild-ircd":
    command     => "/bin/cat ${basedir}/ircd.d/* > $conffile",
    refreshonly => true,
    subscribe   => [File["${basedir}/ircd.d"], File["00-header"]],
  }
  file { "ircd.conf":
    path      => $conffile,
    require   => Package['ircd'],
    mode      => "400",
    owner     => "root",
    subscribe => Exec["rebuild-ircd"],
  }
}
