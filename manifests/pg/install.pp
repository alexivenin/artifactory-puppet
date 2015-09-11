class artifactory::pg::install(
  $package_name        = $artifactory::pg::package_name,
  $data_directory      = $artifactory::pg::data_directory,
  $user                = $artifactory::pg::user,
  $group               = $artifactory::pg::group,
)
{
  package { 'postgresql-$postgresql_version':
    ensure => 'present',
    name   => $package_name,
    notify => Exec['initdb'],
  }
  exec { 'initdb':
    path        => '/bin/:/usr/bin/',
    user        => 'root',
    command     => "pg_createcluster $::artifactory::pg::version main --start",
    refreshonly => true,
  }
}
