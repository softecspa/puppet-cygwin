define cygwin::wget (
  $url      = '',
  $path     = '',
  $onetime  = true,
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

  $creates = $onetime?{
    true  => $dst_path,
    false => undef,
  }

  exec {"wget ${name}":
    command => "wget ${real_url} -O ${dst_path}",
    path    => "${cygwin::path}\\bin",
    creates => $creates
  }

}
