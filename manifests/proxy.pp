class jenkins::proxy inherits jenkins{

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $proxy_host and $proxy_port {

    String $proxy_xml = "${jenkins::localstatedir}/proxy.xml"

    file { $proxy_xml:
      content => epp('jenkins/proxy.xml.epp'),
      owner   => $jenkins::user,
      group   => $jenkins::group,
      mode    => '0644'
    }

    Package['jenkins'] ->
    File[$proxy_xml] ~>
    Service['jenkins']

  }
}