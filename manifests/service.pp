class service ($ensure = "running", $enable = "true") {
  require ircd

  service { "ircd":
    name    => "unreal",
    ensure  => $ensure,
    enable  => $enable,
    #require => File['ircd.conf'],
  }
}
