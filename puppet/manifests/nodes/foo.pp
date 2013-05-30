node /^foo/ {

  notify {'hiera example':
    message => hiera('hiera_example', 'UNDEFINED'),
  }

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
