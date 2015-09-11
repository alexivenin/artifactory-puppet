class artifactory::nginx {
  package { 
  'nginx':
    ensure  => $::artifactory::nginx_version;
  }
  file {
    '/var/www':
      ensure  => 'directory',
      owner   => "root",
      group   => "root";
    '/etc/nginx/ssl':
      ensure  => 'directory',
      owner   => "root",
      group   => "nginx",
      mode    => '0750';
    '/etc/nginx/ssl/server.key':
      ensure  => present,
      source  => 'puppet:///modules/artifactory/server.key',
      owner   => "root",
      group   => "nginx",
      mode    => '0440',
      notify  => Service['nginx'],
      require => [ Package['nginx'], File['/etc/nginx/ssl']];
    '/etc/nginx/ssl/server.crt':
      ensure  => present,
      source  => 'puppet:///modules/artifactory/server.crt',
      owner   => "root",
      group   => "nginx",
      mode    => '0440',
      notify  => Service['nginx'],
      require => [ Package['nginx'], File['/etc/nginx/ssl']];
    '/etc/nginx/nginx.conf':
      ensure  => present,
      source  => 'puppet:///modules/artifactory/nginx.conf',
      mode    => '0644',
      notify  => Service['nginx'],
      require => Package['nginx'];
    '/etc/nginx/sites-enabled/artifactory.conf':
      ensure  => present,
      content  => template('artifactory/nginx-artifactory.erb'),
      mode    => '0644',
      notify  => Service['nginx'],
      require => Package['nginx'];
  }
  service {
    'nginx':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      restart    => '/usr/sbin/service nginx reload',
      require    => Package['nginx'];
  }
}

