# == Class: autofs::params
#
# Centralizes (distro specific) parameter defaults.
#
class autofs::params {

  case $::osfamily {
    'RedHat': {
      $master     = '/etc/auto.master'
      $owner      = 'root'
      $group      = 'root'
      $mode       = '0644'
      $package    = [ 'autofs' ]
      $service    = 'autofs'
    }
    default: {
      fail("osfamily not supported: ${::osfamily}")
    }
  }

}
