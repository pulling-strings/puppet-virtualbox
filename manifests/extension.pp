# Setting up the extension module
class virtualbox::extension(
  $version = '5.1.26',
  $revision= '117224'
){

  $tar = "Oracle_VM_VirtualBox_Extension_Pack-${version}-${revision}.vbox-extpack"
  $url = "http://download.virtualbox.org/virtualbox/${version}/${tar}"

  exec{'download extension':
    command => "wget ${url} -P /tmp ",
    user    => 'root',
    path    => ['/usr/bin','/bin'],
    unless  => "test -f ${tar}",
    timeout => 600
  } ->

  exec{'install extension':
    command => "yes | vboxmanage extpack install --replace /tmp/${tar}",
    user    => 'root',
    path    => ['/usr/bin','/bin',],
    unless  => "/usr/bin/VBoxManage list extpacks | grep ${version}"
  }

}
