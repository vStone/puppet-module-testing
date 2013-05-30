node /^bar/ {

  package {'mysql-server':
    ensure => 'installed',
    alias  => 'mysqld',
  } ->
  service {'mysqld':
    ensure => 'running',
    enable => true,
    alias  => 'mysql',
  }

}
