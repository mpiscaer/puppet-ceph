# Create the ceph keyring
#
define ceph::key (
  $secret       = undef,
  $keyring_path = "/var/lib/ceph/tmp/${name}.keyring",
  $ceph_cluster
) {

  exec { "ceph-key-${name}":
    command => "/usr/bin/ceph-authtool ${keyring_path} --create-keyring --name='client.${name}' --add-key='${secret}'",
    creates => $keyring_path,
    require => Package['ceph'],
  }
}
