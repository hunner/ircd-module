class ircd::package ($ensure = "present") {
  require ircd

  # Name and provider of package based on operating system
  case $operatingsystem {
    'freebsd': {
      package { "ircd":
        name     => "irc/unreal",
        ensure   => "present",
        provider => "portupgrade",
      }
    }
    default: {
      notify { 'Package["ircd"]':
        message => "Not defined for $operatingsystem",
      }
    }
  }
}
