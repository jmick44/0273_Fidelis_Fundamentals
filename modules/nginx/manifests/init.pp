class nginx (
  $message  = "Stuff and things",
  $package  = $nginx::params::package,
  $owner    = $nginx::params::owner,
  $group    = $nginx::params::group,
  $docroot  = $nginx::params::docroot,
  $confdir  = $nginx::params::confdir,
  $blockdir = $nginx::params::blockdir,
  $logdir   = $nginx::params::logdir,
  $service  = $nginx::params::service,
  $user     = $nginx::params::user,
) inherits nginx::params {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0664',
  }

  notify { "$message": }

  package { $package:
    ensure => present,
    before => File["${confdir}/nginx.conf","${blockdir}/default.conf"],
  }

  file { "$docroot":
    ensure => directory,
    #owner  => 'root',
    #group  => 'root',
    mode   => '0755',
  }

  file { "${docroot}/index.html":
    ensure  => file,
    #owner  => 'root',
    #group  => 'root',
    #mode   => '0664',
    #source => 'puppet:///modules/nginx/index.html',
    content => epp('nginx/index.html.epp'),
  }

  file { "${confdir}/nginx.conf":
    ensure  => file,
    #owner  => 'root',
    #group  => 'root',
    #mode   => '0664',
    #source => 'puppet:///modules/nginx/nginx.conf',
    content => epp('nginx/nginx.conf.epp',
                    {
                      user     => $user,
                      logdir   => $logdir,
                      confdir  => $confdir,
                      blockdir => $blockdir,
                    }),
    notify  => Service[$service],
  }

  file { "${blockdir}/default.conf":
    ensure  => file,
    #owner  => 'root',
    #group  => 'root',
    #mode   => '0664',
    #source => 'puppet:///modules/nginx/default.conf',
    content => epp('nginx/default.conf.epp',
                    {
                      docroot => $docroot,
                    }),
    notify  => Service[$service],
  }

  service { $service:
    ensure => running,
    enable => true,
  }

  $vhosts = ['jaime.puppet.com','pappy.puppet.com','default.puppet.com']

  nginx::vhost { $vhosts:
    port => '90',
  }

  nginx::vhost { 'elmo.puppet.com': }
}






