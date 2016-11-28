#
# Support for directly downloading a package file - for when no repository
# is available
#
class jenkins::direct_download inherits jenkins {
  
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  # directory for temp files
  file { $::package_cache_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  # equivalent to basename() - get the filename
  $package_file = regsubst($::direct_download, '(.*?)([^/]+)$', '\2')
  $local_file = "${::package_cache_dir}/${package_file}"

  if $jenkins::version != 'absent' {    
    # make download optional if we are removing...
    archive { $package_file:
      source       => $::direct_download,
      path         => $local_file,
      proxy_server => "http://${::proxy_host}:${::proxy_port}",
      cleanup      => false,
      extract      => false,
      before       => Package[$::package_name],
    }
  }

  package { $::package_name:
    ensure   => $::version,
    provider => $::package_provider,
    source   => $local_file,
  }
}