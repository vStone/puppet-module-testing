# == Definition: autofs::mount
#
# Add specific mount to a mountfile
#
#
define autofs::mount (
  $host,
  $location,
  $map,
  $ensure     = 'present',
  $options    = "-rw,noatime,nocto,hard,intr,nfsvers=3,lookupcache=pos,rsize=32768,wsize=32768,proto=tcp",
) {

  case $map {
    /^(\/etc\/)?(auto\.)?(\w+)$/: {
      $_title = "${3}-${title}"
      $_mapfile = "/etc/auto.${3}"
    }
    default: {
      fail ("Unable to determine the map file to use: ${map}")
    }
  }

  Augeas {
    incl    => $_mapfile,
    lens    => 'Automounter.lns',
    require => File[$_mapfile],
    notify  => Service['autofs'],
  }

  $context = "*[label() != '#comment'][ . = '${title}']"

  case $ensure {
    'absent': {
      augeas {"autofs::mount::rm-${_title}":
        changes => "rm ${context}",
      }
    }
    'present', default: {
      augeas {"autofs::mount::add-${_title}":
        changes => template('autofs/autofs-mount-add.augeas.erb'),
        onlyif  => "match ${context} size == 0",
      }
      augeas {"autofs::mount::update-${_title}":
        before  => Augeas["autofs::mount::add-${_title}"],
        changes => template('autofs/autofs-mount-update.augeas.erb'),
        onlyif  => "match ${context} size > 0",
      }
    }
  }

}
