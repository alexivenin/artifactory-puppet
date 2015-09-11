class artifactory::pg (
  $version               = '9.3',
  $package_name          = 'postgresql-9.3',

  $pg_conf               = '/etc/postgresql/9.3/main/postgresql.conf',
  $data_directory        = '/var/lib/postgresql/9.3/main',
  $hba_file              = '/etc/postgresql/9.3/main/pg_hba.conf',
  $ident_file            = '/etc/postgresql/9.3/main/pg_ident.conf',
  $external_pid_file     = '/var/run/postgresql/9.3-main.pid',

  $listen_addresses      = 'localhost',
  $pg_port               = '5432',
  $max_connections       = '100',
  $unix_socket_directory = '/var/run/postgresql',
  $ssl                   = true,
  $shared_buffers        = '24MB',
  $locale                = 'en_US.UTF-8',

  $group                 = 'postgres',
  $user                  = 'postgres',
  $ip_mask_allow_ipv4    = '127.0.0.1/32',

  $pg_database           = 'artifactory',
  $pg_user               = 'artifactory',
  $pg_pass               = 'PG_PASS',
)
{
  class { 'artifactory::pg::install': } ->
  class { 'artifactory::pg::config': } ->
  class { 'artifactory::pg::grants': }
}
