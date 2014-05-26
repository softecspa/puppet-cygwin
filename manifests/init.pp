class cygwin (
  $tmp_dir    = 'C:\\vagrant-init\\tmp',
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
