class artifactory::artifactory {
  $tpl_artifactory_home = "$::artifactory::artifactory_path-$::artifactory::artifactory_version"
  $tpl_artifactory_name = "artifactory-$::artifactory::artifactory_version"

  package { "$tpl_artifactory_name":
    ensure  => present,
  }
  file {
    "/etc/opt/jfrog/$tpl_artifactory_name/default":
      ensure  => present,
      content  => template('artifactory/artifactory-default.erb'),
      mode    => '0644',
      owner   => "artifactory",
      group   => "root",
      notify  => Service[$tpl_artifactory_name],
      require => Package[$tpl_artifactory_name];
    "$tpl_artifactory_home/tomcat/conf/server.xml":
      ensure  => present,
      content  => template('artifactory/artifactory-tomcat-server-xml.erb'),
      mode    => '0644',
      owner   => "artifactory",
      group   => "root",
      notify  => Service[$tpl_artifactory_name],
      require => Package[$tpl_artifactory_name];
    "$tpl_artifactory_home/tomcat/conf/Catalina/localhost/artifactory.xml":
      ensure  => present,
      content => template('artifactory/artifactory-tomcat-xml.erb'),
      mode    => '0644',
      owner   => "artifactory",
      group   => "root",
      notify  => Service[$tpl_artifactory_name],
      require => Package[$tpl_artifactory_name];
    "/etc/opt/jfrog/$tpl_artifactory_name/artifactory.system.properties":
      ensure  => present,
      source  => 'puppet:///modules/artifactory/artifactory.system.properties',
      mode    => '0644',
      owner   => "artifactory",
      group   => "root",
      notify  => Service[$tpl_artifactory_name],
      require => Package[$tpl_artifactory_name];
    '/home/artifactory/.artifactory/':
      ensure  => 'directory',
      owner   => "artifactory",
      group   => "artifactory",
      require => Package[$tpl_artifactory_name];
    '/home/artifactory/.artifactory/etc/':
      ensure  => 'directory',
      owner   => "artifactory",
      group   => "artifactory",
      require => [ Package[$tpl_artifactory_name], File['/home/artifactory/.artifactory/'] ];
  }
  service {
    "$tpl_artifactory_name":
      ensure     => running,
      enable     => true,
      hasrestart => true,
      restart    => "/usr/sbin/service $tpl_artifactory_name restart",
      require    => Package["$tpl_artifactory_name"];
  }
}
