# == Class: jenkins
#
# Module to manage Jenkins
#
# == Paramters:
#
# (Boolean) lts = true (Default)
#   Use LTS verison of jenkins
#
# (Boolean) lts = false
#   Use the most up to date version of jenkins
#
# (Boolean) repo = true (Default)
#   Install the jenkins repo.
#
# (Boolean) repo = false
#   Do NOT install a repo. This means you'll manage a repo manually outside
#   this module.
#   This is for folks that use a custom repo, or the like.
#
# (Optional[String]) repo_proxy = undef (Default)
#   If you environment requires a proxy to download packages
#
# (Optional[String]) direct_download = 'http://...'
#   Ignore repostory based package installation and download and install
#   package directly.  Leave as `undef` (the default) to download using your
#   OS package manager
#
# (String) package_name = 'jenkins'
#   Optionally override the package name
#
# (String) version = 'installed' (Default)
#   Will NOT update jenkins to the most recent version.
#
# (String) version = 'latest'
#   Will automatically update the version of jenkins to the current version
#   available via your package manager.
#
# (String) package_provider = OS Dependant (default)
#   Which OS Package Manager to use to install jenkins
#   - Redhat = rpm
#   - Debian = dpkg
#
# (Stdlib::Absolutepath) package_cache_dir  = '/var/cache/jenkins_pkgs'
#   Optionally specify an alternate location to download packages to when using
#   direct_download
#
# (String) proxy_host = undef (default)
# (Integer) proxy_port = undef (default)
#   If your environment requires a proxy host to download plugins it can be configured here
#
# (Array[String]) no_proxy_list = undef (default)
#   List of hostname patterns to skip using the proxy.
#   - Accepts input as array only.
#   - Only effective if "proxy_host" and "proxy_port" are set.
#
# (String) localstatedir = '/var/lib/jenkins' (default)
#   Base path, in the autoconf sense, for jenkins local data including jobs and
#   plugins
#
# (String) user = 'jenkins' (default)
#`  System user that owns the jenkins master's files
#
# (Boolean) manage_user = true (default)
#   Manage system user that owns the jenkins master's files
#
# (String) group = 'jenkins' (default)
#`  System group that owns the jenkins master's files
#
# (Boolean) manage_group = true (default)
#   Manage system group that owns the jenkins master's files
#
class jenkins (
  Boolean $lts,
  Boolean $repo,
  Optional[String] $repo_proxy,
  Optional[String] $direct_download,
  String $package_name,
  String $version,
  String $package_provider,
  Stdlib::Absolutepath $package_cache_dir,
  Optional[String] $proxy_host,
  Optional[Integer] $proxy_port,
  Optional[Array[String]] $no_proxy_list,
  String $localstatedir,
  String $user,
  Boolean $manage_user,
  String $group,
  Boolean $manage_group,
  Hash[String, String] $config_hash_defaults,
  Optional[Hash[String, String]] $config_hash,
) {

  $plugin_dir = "${jenkins::localstatedir}/plugins"
  $job_dir = "${jenkins::localstatedir}/jobs"

  if $direct_download {
    $use_repo = false
    $jenkins_package_class = '::jenkins::direct_download'
  } else {
    $jenkins_package_class = '::jenkins::package'
    if $repo {
      $use_repo = true
      include jenkins::repo
    } else {
      $use_repo = false
    }
  }

  contain $jenkins_package_class
  contain jenkins::config
  contain jenkins::proxy

  Class[$jenkins_package_class] ->
  Class['::jenkins::config'] ->
  Class['::jenkins::plugins'] ~>
  Class['::jenkins::service'] ->
  Class['::jenkins::jobs']

  if $jenkins::install_java {
      Class['java'] -> Class[$jenkins_package_class]
  }

  if $jenkins::use_repo {
      Class['::jenkins::repo'] -> Class['::jenkins::package']
  }
}