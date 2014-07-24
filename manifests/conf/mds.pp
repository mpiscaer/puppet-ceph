# Define a mds
#
define ceph::conf::mds (
  $mds_data,
  $config = {},
  $ceph_cluster
) {
  validate_hash($config)

  @@concat::fragment { "ceph-mds-${$ceph_cluster}-${name}.conf":
    target  => '/etc/ceph/ceph.conf',
    order   => '60',
    content => template('ceph/ceph.conf-mds.erb'),
    tag     => "$ceph_cluster"
  }

}
