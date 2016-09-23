class system_users::admins {
  user { 'admin':
    ensure => present,
    shell  => '/bin/csh',
    gid    => 'staff',
  }

  group { 'staff':
    ensure => present,
  }
}
