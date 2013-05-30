class autofs::service (
  $service = $::autofs::service,
) {

  service { $service:
    ensure    => running,
    alias     => 'autofs',
    enable    => true,
    hasstatus => true,
    require   => Package['autofs'],
  }

}
