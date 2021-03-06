# Define a mon
#
define ceph::conf::mon (
  $mon_addr,
  $mon_port,
  $config = {},
  $ceph_hostname,
  $ceph_cluster
) {
  validate_hash($config)

  concat::fragment { "ceph-mon-${ceph_cluster}-${name}-${fqdn}.conf":
    target  => '/etc/ceph/ceph.conf',
    order   => '50',
    content => template('ceph/ceph.conf-mon.erb'),
  }

}
