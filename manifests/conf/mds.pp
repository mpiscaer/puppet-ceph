# Define a mds
#
define ceph::conf::mds (
  $config = {},
  $ceph_cluster,
  $ceph_hostname
) {
  validate_hash($config)

  concat::fragment { "ceph-mds-${ceph_cluster}-${name}.conf":
    target  => '/etc/ceph/ceph.conf',
    order   => '60',
    content => template('ceph/ceph.conf-mds.erb'),
  }

}
