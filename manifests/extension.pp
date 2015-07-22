# Setting up the extension module
class virtualbox::extension(
  $version = '5.0.0',
  $revision= '101573'
){

  $tar = "Oracle_VM_VirtualBox_Extension_Pack-${version}-${revision}.vbox-extpack"
  $url = "http://download.virtualbox.org/virtualbox/${version}/${tar}"

  exec{'install extension':
    command => "wget ${url} -P /tmp && vboxmanage extpack install --replace /tmp/${tar}",
    user    => 'root',
    path    => ['/usr/bin','/bin'],
    unless => "/usr/bin/VBoxManage list extpacks | grep ${version}"
  }

}
