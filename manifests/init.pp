class artifactory  (
  $nginx_version                           = 'present',
  $nginx_server_name                       = $fqdn,
  $artifactory_version                     = '4.1.0',
  $artifactory_proxy_pass                  = 'http://localhost:8081',
  $artifactory_nginx_ssl_certificate       = '/etc/nginx/ssl/server.crt',
  $artifactory_nginx_ssl_certificate_key   = '/etc/nginx/ssl/server.key',
  $artifactory_path                        = '/opt/artifactory-powerpack',
  $artifactory_user                        = 'artifactory',
  $artifactory_java_options                = '-server -Xms512m -Xmx2g -Xss256k -XX:PermSize=128m -XX:MaxPermSize=256m -XX:+UseG1GC -Djruby.compile.invokedynamic=false -Dfile.encoding=UTF8',
  $artifactory_tomcat_port                 = '8081',
  $artifactory_tomcat_maxthreads           = '500',
  $artifactory_tomcat_minsparethreads      = '20',
  $artifactory_tomcat_enablelookups        = false,
  $artifactory_tomcat_disableuploadtimeout = true,
  $artifactory_tomcat_backlog              = '100',
)
{
  include artifactory::artifactory
  include artifactory::nginx
  include artifactory::pg
}

