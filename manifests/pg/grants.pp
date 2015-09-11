# Do not use this class directly
class artifactory::pg::grants (
  $pg_database = $artifactory::pg::pg_database,
  $pg_user     = $artifactory::pg::pg_user,
  $pg_pass     = $artifactory::pg::pg_pass,
)
{
  $usercheck = "psql --command \"\\du ${pg_user}\" | grep -c ${pg_user}"
  $setpasswd = "psql -c \"ALTER USER ${pg_user} WITH PASSWORD \'${pg_pass}\';\""

  exec { 'prepare':
    path    => '/bin/:/usr/bin/',
    user    => 'postgres',
    command => "createuser -DRSw ${pg_user} && ${setpasswd} && createdb -E UTF8 -O ${pg_user} ${pg_database}",
    unless  => $usercheck
  }
  file {
    "/home/artifactory/.artifactory/etc/storage.properties":
      ensure  => present,
      content => template('artifactory/artifactory-storage-properties.erb'),
      mode    => '0644',
      owner   => "artifactory",
      group   => "root",
      notify  => Service[$::artifactory::artifactory::tpl_artifactory_name],
      require => [ Package[$::artifactory::artifactory::tpl_artifactory_name], File['/home/artifactory/.artifactory/etc/'] ];
  }
}
