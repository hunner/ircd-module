define ircd::server ($info = "IRC server", $numeric, $admin = "Admin", $ulines = "", $networkname = "IRC network", $defaultserver = "nothing", $servicesserver = "", $cloaks = ["one","two","three"], $ulines = "", $restartpass, $diepass) {
  require ircd

  #TODO Make the user/group for ircd to run as an option


  # To set the name of the server. Uses $name unless specified
  if $defaultserver == "nothing" {
    $defaultserverconf = $name
  } else {
    $defaultserverconf = $defaultserver
  }

  # Location of the conf file based on operating system
  $conffile = $operatingsystem ? {
    'freebsd' => "/usr/local/etc/Unreal/unrealircd.conf",
    default   => "/etc/Unreal/unrealircd.conf",
  }

  file { "ircd.conf":
    path      => $conffile,
    #require   => Class['ircd'],
    mode      => "400",
    owner     => "root",
    subscribe => Exec["rebuild-unreal"],
  }

  file { "00-header":
    path    => "${basedir}/ircd.d/00-header",
    content => template("ircd/unreal-header.erb"),
  }
}
