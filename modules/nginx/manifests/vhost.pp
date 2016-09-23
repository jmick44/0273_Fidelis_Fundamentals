define nginx::vhost (
  $port = '80',
){
  file { "/var/www/${title}":
    ensure => directory,
  }

  file { "/var/www/${title}/${title}.conf":
    ensure  => file,
    content => "port = ${port}",
  }
}
