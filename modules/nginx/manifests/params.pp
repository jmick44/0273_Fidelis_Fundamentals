class nginx::params  {
  case $os['family'] {
    'redhat','debian' : {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d'
      $logdir = '/var/log/nginx'
      $service = 'nginx'
    }
    default : {
      fail("This module is not supported on $os['family']")
    }
  }

  $user = $::osfamily ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
    default  => 'fail',
  }

  if $user == 'fail' {
    fail("This module is not supported on $osfamily")
  }
}






