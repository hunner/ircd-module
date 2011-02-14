define ircd::link ($username = "*", $hostname, $bindip = "*", $port, $hub = "*", $password, $options = "", $ensure = "present") {
  require ircd
  if $ssl {
    $enablessl = "    ssl;\n"
  }
  if $serveronly == "true" {
    $allow = "serversonly"
  } else {
    $allow = "clientsonly"
  }
  file { "${ircd::basedir}/ircd.d/link-${name}":
    content => template("ircd/unreal-link.erb"),
    notify  => Exec["rebuild-ircd"],
    ensure  => $ensure,
  }
}
