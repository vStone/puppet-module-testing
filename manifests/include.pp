# == Definition: autofs::include
#
# Includes an entry to the autofs master file.
#
# === Parameters
#
# [*ensure*]
#  valid values are present and absent.
#
# [*purge*]
#   If true, also remove the mapfile when removing an entry from the master file.
#
# [*mount*]
#   Directory where mounts will resize. Default is deducted from the title.
#
# [*mapfile*]
#   Mapfile to include. Default is /etc/auto.$mount
#
# [*masterfile*]
#   Master file to add this entry to. Defaults to distro specific.
#
# === Sample usage:
#
# TODO: Include an example.
#
define autofs::include (
  $ensure   = 'present',
  $purge    = false,
  $mapfile  = undef,
  $mount    = undef,
  $masterfile = undef
) {

  require autofs

  ## Deal with parameters

  # Sanitize the title (strip 'auto.' if present)
  $_title = regsubst($title, '^(auto\.)?(\w+)$', '\2')

  # Mount point is '/<sanitized_title>' by default.
  $_mount = $mount ? {
    undef   => "/${_title}",
    default => $mount,
  }

  # Mapfile is '/etc/auto.<sanitized_title>' by default.
  $_mapfile = $mapfile ? {
    undef   => "/etc/auto.${_title}",
    default => $mapfile,
  }

  # Masterfile is whatever is in the autofs class by default.
  $_masterfile = $masterfile ? {
    undef   => $::autofs::master,
    default => $masterfile,
  }


  # The mapfile
  file {$_mapfile:
    owner  => $autofs::owner,
    group  => $autofs::group,
    before => Service['autofs'],
  }

  case $ensure {
    'absent': {
      # if purge is enabled, remove the mapfile too.
      if $purge {
        File[$_mapfile] { ensure => 'absent', }
      }
    }
    'present',default: {
      File[$_mapfile] { ensure => 'present', }
    }

  }
}
