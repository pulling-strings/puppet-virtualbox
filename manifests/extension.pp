# Setting up the extension module
class virtualbox::extension {

  $tar = 'Oracle_VM_VirtualBox_Extension_Pack-4.2.6-82870.vbox-extpack'
  $url = "http://download.virtualbox.org/virtualbox/4.2.6/${tar}"

  exec{'install extension':
    command     => "wget ${url} -P /tmp && vboxmanage extpack install /tmp/${tar}",
    user        => 'root',
    path        => ['/usr/bin','/bin',],
    refreshonly => true
  }

}