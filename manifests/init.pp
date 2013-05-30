# == Class: autofs
#
# Installs package and sets up service
#
# === Todo
#
# TODO: Default options.
#
class autofs (
  $owner   = $::autofs::params::owner,
  $group   = $::autofs::params::group,
  $mode    = $::autofs::params::mode,
  $master  = $::autofs::params::master,
  $package = $::autofs::params::package,
  $service = $::autofs::params::service
  #$mounts is NOT used here! They are used in autofs::loader with hiera_hash
) inherits autofs::params {

  include autofs::package
  include autofs::config
  include autofs::service

}
