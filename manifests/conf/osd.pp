# Define a osd
#
define ceph::conf::osd (
  $device,
  $cluster_addr = undef,
  $public_addr  = undef,
  $journal = undef,
  $journalsize = undef,
  $config = {},
  $ceph_cluster
) {
  validate_hash($config)

  concat::fragment { "ceph-osd-${ceph_cluster}-${name}.conf":
    target  => '/etc/ceph/ceph.conf',
    order   => '80',
    content => template('ceph/ceph.conf-osd.erb'),
  }

}
