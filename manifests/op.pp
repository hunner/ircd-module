define ircd::op ($hostmasks, $password, $flags = "unset", $level = "local", $modes = "-q+ptW", $snomask = "kcfFveGnNqSsoj", $ensure = "present") {
  require ircd
  if $flags == "unset" {
    case $level {
      default: {
        $opflags = ['can_die','can_restart','can_umodew','local']
      }
      "global": {
        $opflags = ['can_die','can_restart','can_umodew','global']
      }
      "admin": {
        $opflags = ['can_die','can_restart','can_umodew','admin']
      }
      "services-admin": {
        $opflags = ['can_die','can_restart','can_umodew','services-admin']
      }
      "netadmin": {
        $opflags = ['can_die','can_restart','can_umodew','can_override','netadmin']
      }
    }
  } else {
    $opflags = $flags
  }
  file { "${ircd::basedir}/ircd.d/${name}":
    content => template("ircd/unreal-op.erb"),
    notify  => Exec["rebuild-ircd"],
    ensure  => $ensure,
  }
}
