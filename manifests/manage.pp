# Misc managment options
class virtualbox::manage(
  $machinefolder = '',
  $user = ''
){
  if($machinefolder != ''){
    exec{"set machinefolder to ${machinefolder}":
      command => "vboxmanage setproperty machinefolder ${machinefolder}",
      user    => $user,
      path    => ['/usr/bin','/bin',],
      require => Package[$virtualbox::package_real]
    }
  }
}
