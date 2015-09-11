class artifactory::pg::config (

  $ip_mask_allow_ipv4    = $artifactory::pg::ip_mask_allow_ipv4,
  $pg_conf               = $artifactory::pg::pg_conf,
  $data_directory        = $artifactory::pg::data_directory,
  $hba_file              = $artifactory::pg::hba_file,
  $external_pid_file     = $artifactory::pg::external_pid_file,
  $listen_addresses      = $artifactory::pg::listen_addresses,
  $port                  = $artifactory::pg::pg_port,
  $max_connections       = $artifactory::pg::max_connections,
  $unix_socket_directory = $artifactory::pg::unix_socket_directory,
  $ssl                   = $artifactory::pg::ssl,
  $shared_buffers        = $artifactory::pg::shared_buffers,
  $locale                = $artifactory::pg::locale,
)
{

  service {'postgresql':
    ensure => running,
    enable => true,
  }
  file { 'hba-file':
    path    => $hba_file,
    owner   => 'postgres',
    group   => 'postgres',
    mode    => '0640',
    content => template('artifactory/pg_hba.conf.erb'),
    notify  => Service['postgresql'],
  }

  file { 'postgresql.conf':
    path    => $pg_conf,
    owner   => 'postgres',
    group   => 'postgres',
    mode    => '0644',
    content => template('artifactory/postgresql.conf.erb'),
    notify  => Service['postgresql'],
  }
}
