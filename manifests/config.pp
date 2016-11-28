# This class should be considered private
#
class jenkins::config inherits jenkins {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  ensure_resource('jenkins::plugin', $jenkins::default_plugins)

  $config_hash = merge(
    $jenkins::config_hash_defaults,
    $jenkins::config_hash
  )
  create_resources('jenkins::sysconfig', $config_hash)

  $directory_defaults = {
    ensure => directory,
    owner  => $jenkins::user,
    group  => $jenkins::group,
    mode   => '0755',
  }

  if $jenkins::manage_user {
    ensure_resource('user', $jenkins::user, {
      ensure     => present,
      gid        => $jenkins::group,
      home       => $jenkins::localstatedir,
      managehome => false,
      system     => true,
    })
  }

  if $jenkins::manage_group {
    ensure_resource('group', $jenkins::group, {
      ensure => present,
      system => true,
    })
  }

  if $::jenkins::manage_datadirs {
    ensure_resource('file', $jenkins::localstatedir, $directory_defaults)
    ensure_resource('file', $jenkins::plugin_dir, $directory_defaults)
    ensure_resource('file', $jenkins::job_dir, $directory_defaults)
  }
}