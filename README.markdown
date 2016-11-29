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
true: Use LTS verison of jenkins.

false: Use the most up to date version of jenkins.
- *Default*: true

repo (Boolean)
-------------
true: Install the jenkins repo

false: Do NOT install a repo. This means you'll manage a repo manually outside this module. This is for folks that use a custom repo, or the like.
- *Default*: true

repo_proxy (Optional[String])
-------------
If you environment requires a proxy to download packages.
- *Default*: none

direct_download (Optional[String])
-------------
Ignore repostory based package installation and download and install package directly. Don't include to download using your OS package manager.
- *Default*: none

package_name (String)
-------------
Optionally override the package name.
- *Default*: `jenkins`

version (String)
-------------
`installed`: Will NOT update jenkins to the most recent version.
`latest`:  Will automatically update the version of jenkins to the current version available via your package manager.
- *Default*: `installed`

package_provider (String)
-------------
Which OS Package Manager to use to install jenkins.
* Redhat: `rpm`
* Debian: `dpkg`
- *Default*: OS Dependant

package_cache_dir (Stdlib::Absolutepath)
-------------
Optionally specify an alternate location to download packages to when using direct_download.
- *Default*: `/var/cache/jenkins_pkgs`

proxy_host (String)
proxy_port (Integer)
-------------
If your environment requires a proxy host to download plugins it can be configured here.
- *Default*: `undef`

no_proxy_list (Array[String])
-------------
List of hostname patterns to skip using the proxy.
* Accepts input as array only.
* Only effective if "proxy_host" and "proxy_port" are set.
- *Default*: `undef`

localstatedir (String)
-------------
Base path, in the autoconf sense, for jenkins local data including jobs and plugins
- *Default*: `/var/lib/jenkins`

user (String)
-------------
System user that owns the jenkins master's files
- *Default*: `jenkins`

manage_user (Boolean)
-------------
Manage system user that owns the jenkins master's files
- *Default*: true

group (String)
-------------
System group that owns the jenkins master's files
- *Default*: `jenkins`

manage_group (Boolean)
-------------
Manage system group that owns the jenkins master's files
- *Default*: true
