class autofs::config (
  $master = $::autofs::master,
  $owner  = $::autofs::owner,
  $group  = $::autofs::group,
  $mode   = $::autofs::mode,
) inherits autofs {

  # By declaring the file here, we (kinda) block
  # another module to manage this by (for example) a template.
  # That would result in endless augeas and template cycles.
  # We also notify the autofs service when the file changes. How about that.
  file {$master:
    notify => Service['autofs'],
    owner  => $owner,
    group  => $group,
    mode   => $mode,
  }

}
