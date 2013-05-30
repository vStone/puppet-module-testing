class autofs::package (
  $package = $::autofs::package
) inherits autofs {

  package { $package:
    ensure => installed,
    alias  => 'autofs',
    notify => Service['autofs'],
  }
}
