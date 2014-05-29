# ==Class cygwin
#
# Install cygwin packages
#
# ===Parameters
#
# [*tmp_dir*]
#   temp dir used to download the installer. Mandatory
#
# [*mirror_src*]
#   Mirror used to download packages. Default http://cygwin.mirror.constant.com
#
# [*packages*]
#   Comma separated list of packages to install. Default: wget,openssh
#
# ===Examples
#
# Install wget, openssh and curl packages
#
#   class {'cygwin':
#     packages  => 'wget,openssh,curl'
#   }
#
# === Authors
#
# Author Name Felice Pizzurro <felice.pizzurro@softecspa.it>
#
# === Copyright
#
# Copyright 2014 Softec SpA
#
class cygwin (
  $tmp_dir,
  $mirror_src = 'http://cygwin.mirror.constant.com',
  $packages   = 'openssh,wget',
) {

  if $::operatingsystem != 'windows' {
    fail('cygwin module supports only windows OS')
  }

  $arch = $::architecture?{
    'i386'  => 'x86',
    'x86'   => 'x86',
    'amd64' => 'x86_64',
    'x64'   => 'x86_64',
  }

  $path = $::architecture?{
    'i386'  => 'C:\\cygwin',
    'x86'   => 'C:\\cygwin',
    'amd64' => 'C:\\cygwin64',
    'x64'   => 'C:\\cygwin64',
  }

  $x86 = $::architecture?{
    'i386'  => '',
    'x86'   => '',
    'amd64' => ' (x86)',
    'x64'   => ' (x86)',
  }

  exec {'download_cygwin':
    command => "wget.exe http://cygwin.com/setup-${arch}.exe -O ${tmp_dir}\\setup-${arch}.exe",
    cwd     => "C:\\Program Files${x86}\\GnuWin32\\bin",
    path    => "C:\\Program Files${x86}\\GnuWin32\\bin;${::path}",
    creates => "${tmp_dir}\\setup-${arch}.exe",
  }

  exec {'install cygwin':
    command => "${tmp_dir}\\setup-${arch}.exe -q -s ${mirror_src} -P ${packages} -B",
    creates => $path,
    require => Exec['download_cygwin']
  }

  windows_path{'cygwin':
    ensure    => 'present',
    directory => "${path}\\bin\\",
    require   => Exec['install cygwin']
  }
}
