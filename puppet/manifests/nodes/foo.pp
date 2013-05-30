node /^foo/ {

  package {'httpd':
    ensure => 'installed',
    alias  => 'apache',
  } ->
  service {'httpd':
    ensure => 'running',
    enable => true,
    alias  => 'apache',
  }

}
