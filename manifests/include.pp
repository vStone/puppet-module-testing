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

  # For all augeas stuff we use.
  Augeas {
    incl    => $_masterfile,
    lens    => 'Automaster.lns',
  }

  $context = "*[label() != '#comment'][. = '${_mount}']"

  case $ensure {
    'present',default: {

      augeas {"autofs::include::add-${_mount}":
        changes => [
          "set 01 '${_mount}'",
          "set 01/map '${_mapfile}'",
        ],
        onlyif  => "match ${context} size == 0",
      }

      augeas{"autofs::include::update-${_mount}":
        before  => Augeas["autofs::include::add-${_mount}"],
        changes => "set ${context}/map '${_mapfile}'",
        onlyif  => "match ${context} size > 0",
      }

      File[$_mapfile] { ensure => 'present', }

    }
    'absent': {
      # remove the entry.
      augeas {"autofs::include::rm-${_mount}":
        changes => "rm ${context}",
      }
      # if purge is enabled, remove the mapfile too.
      if $purge {
        File[$_mapfile] { ensure => 'absent', }
      }
    }

  }
}
