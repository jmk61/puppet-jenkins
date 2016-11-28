# == Class: jenkins::repo
#
# Class to manage jenkins repo both long term support
# or latest release for enterprise linux operating
# systems. This includes RedHat Linux, CentOS, and
# Fedora operating systems.
#
class jenkins::repo::enterprise_linux inherits jenkins {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $::jenkins::lts  {
    yumrepo {'jenkins':
      descr    => 'Jenkins',
      baseurl  => 'http://pkg.jenkins-ci.org/redhat-stable/',
      gpgcheck => 1,
      gpgkey   => 'http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key',
      enabled  => 1,
      proxy    => $jenkins::repo_proxy
    }
  }

  else {
    yumrepo {'jenkins':
      descr    => 'Jenkins',
      baseurl  => 'http://pkg.jenkins-ci.org/redhat/',
      gpgcheck => 1,
      gpgkey   => 'http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key',
      enabled  => 1,
      proxy    => $jenkins::repo_proxy
    }
}
}