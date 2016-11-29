# puppet-jenkins
===

[![Build Status](https://travis-ci.org/jmk61/puppet-jenkins.png?branch=master)](https://travis-ci.org/jmk61/puppet-jenkins)

Puppet module for Jenkins supporting Jenkins 2.

===

# Compatibility
---------------
This module is built for use with Puppet v4 with Ruby versions 2.1.0 and 2.3.1 on the
following OS families.

* EL 6,7
* CentOS 6,7
* Debian 12.04, 14.04

===

# Parameters
------------

lts (Boolean)
-------------
true: Use LTS verison of jenkins

false: Use the most up to date version of jenkins
- *Default*: true

repo (Boolean)
-------------
true: Install the jenkins repo

false: Do NOT install a repo. This means you'll manage a repo manually outside this module.
       This is for folks that use a custom repo, or the like.
- *Default*: true




 (Optional[String]) repo_proxy = undef (Default)
   If you environment requires a proxy to download packages

 (Optional[String]) direct_download = 'http://...'
   Ignore repostory based package installation and download and install
   package directly.  Leave as `undef` (the default) to download using your
   OS package manager

 (String) package_name = 'jenkins'
   Optionally override the package name

 (String) version = 'installed' (Default)
   Will NOT update jenkins to the most recent version.

 (String) version = 'latest'
   Will automatically update the version of jenkins to the current version
   available via your package manager.

 (String) package_provider = OS Dependant (default)
   Which OS Package Manager to use to install jenkins
   - Redhat = rpm
   - Debian = dpkg

 (Stdlib::Absolutepath) package_cache_dir  = '/var/cache/jenkins_pkgs'
   Optionally specify an alternate location to download packages to when using
   direct_download

 (String) proxy_host = undef (default)
 (Integer) proxy_port = undef (default)
   If your environment requires a proxy host to download plugins it can be configured here

 (Array[String]) no_proxy_list = undef (default)
   List of hostname patterns to skip using the proxy.
   - Accepts input as array only.
   - Only effective if "proxy_host" and "proxy_port" are set.

 (String) localstatedir = '/var/lib/jenkins' (default)
   Base path, in the autoconf sense, for jenkins local data including jobs and
   plugins

 (String) user = 'jenkins' (default)
   System user that owns the jenkins master's files

 (Boolean) manage_user = true (default)
   Manage system user that owns the jenkins master's files

 (String) group = 'jenkins' (default)
   System group that owns the jenkins master's files

 (Boolean) manage_group = true (default)
   Manage system group that owns the jenkins master's files
