define ircd::listen ($port, $ip = "*", $ssl = false, $serveronly = "false", $ensure = "present") {
  require ircd
  if $ssl {
    $enablessl = "    ssl;\n"
  } else {
    $enablessl = ""
  }
  if $serveronly == "true" {
    $allow = "serversonly"
  } else {
    $allow = "clientsonly"
  }
  file { "${ircd::basedir}/ircd.d/listen-${name}":
    content => template("ircd/unreal-listen.erb"),
    notify  => Exec["rebuild-ircd"],
    ensure  => $ensure,
  }
}
