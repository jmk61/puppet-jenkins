# == Class: jenkins::repo
#
# Class to manage jenkins repo for various operating systems
#
class jenkins::repo inherits jenkins {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }
  
  if ( $::repo ) {
    case $::osfamily {

      'RedHat', 'Linux': {
        class { 'jenkins::repo::enterprise_linux': }
      }

      'Debian': {
        class { 'jenkins::repo::debian': }
      }

      default: {
        fail( "Unsupported OS family: ${::osfamily}" )
      }
    }
  }  
}