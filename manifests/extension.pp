# Setting up the extension module
class virtualbox::extension {

  $version = '4.3.16'
  $tar = "Oracle_VM_VirtualBox_Extension_Pack-${version}.vbox-extpack"
  $url = "http://download.virtualbox.org/virtualbox/${version}/${tar}"

  exec{'install extension':
    command => "wget ${url} -P /tmp && vboxmanage extpack install --replace /tmp/${tar}",
    user    => 'root',
    path    => ['/usr/bin','/bin'],
    unless => "/usr/bin/VBoxManage list extpacks | grep ${version}"
  }

}
