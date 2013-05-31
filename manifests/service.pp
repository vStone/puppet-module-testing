class autofs::service (
  $service = $::autofs::service,
) inherits autofs {

  service { $service:
    ensure    => running,
    alias     => 'autofs',
    enable    => true,
    hasstatus => true,
    require   => Package['autofs'],
  }

}
