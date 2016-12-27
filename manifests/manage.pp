# VBoxManage options:
#  $hostkey_comb possible values (only on Linux see http://bit.ly/1wxVco2):
#    left_alt, right_alt, right_cont, left_cont
class virtualbox::manage(
  $machinefolder = false,
  $user = false,
  $hostkey_comb = ''
){

  validate_string($user, $machinefolder)

  $keys = {
    left_alt   => '65513', right_alt => '65514',
    right_ctrl => '65508', left_ctrl => '65507'
  }

  if($machinefolder != ''){
    exec{"set machinefolder to ${machinefolder}":
      command => "vboxmanage setproperty machinefolder ${machinefolder}",
      user    => $user,
      path    => ['/usr/bin','/bin',],
      require => Package[$::virtualbox::package_real]
    }
  }

  if($hostkey_comb != '' and $::desktop::is_desktop){
    $key = $keys[$hostkey_comb]
    exec{"set hostkey_comb to ${$hostkey_comb}":
      command => "vboxmanage setextradata global GUI/Input/HostKeyCombination ${key}",
      user    => $user,
      path    => ['/usr/bin','/bin',],
      require => Package[$::virtualbox::package_real]
    }

  }

  exec{"adding ${user} to vboxusers group":
    command => "sudo usermod -aG vboxusers ${user}",
    user    => 'root',
    path    => ['/usr/bin','/bin'],
    unless  => "grep -q 'vboxuser.*${user}' /etc/group",
    require => Package[$::virtualbox::package_real]
  }

}
