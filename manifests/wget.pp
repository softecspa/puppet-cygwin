# ==Define cygwin::wget
#
# Download a file using cygwin wget packages in Windows
#
# ===Parameters
#
# [*url*]
#   Url to the file to download. <name> will be used if empty.
#
# [*path*]
#   Path where download the file. if empty, filename will be used
#
# ===Examples
# * download file from http://www.example.com/file.tar.gz to c:\file.tar.gz
#
#   cygwin::wget {'http://www.example.com/file.tar.gz':
#     path  => 'c:\'
#   }
#
# * download file from http://www.example.com/file.tar.gz to c:\examplefile.tar.gz (note thath filename is different from source)
#
#   cygwin::wget {'http://www.example.com/file.tar.gz':
#     path  => 'c:\examplefile.tar.gz'
#   }
# === Authors
#
# Author Name Felice Pizzurro <felice.pizzurro@softecspa.it>
#
# === Copyright
#
# Copyright 2014 Softec SpA
#
define cygwin::wget (
  $url      = '',
  $path     = '',
) {

  $real_url = $url?{
    ''      => $name,
    default => $url
  }

  $filename = inline_template("<%= @real_url.split('/').at(-1) %>")

  $dst_path= $path?{
    ''      => $filename,
    default => $path
  }

  exec {"wget ${name}":
    command => "wget ${real_url} -O ${dst_path}",
    path    => "${cygwin::path}\\bin",
    creates => $dst_path
  }

}
