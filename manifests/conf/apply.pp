# apply de configurations
#
define ceph::conf::apply (
  $type,
  $ceph_cluster,
  $mon_addr = undef,
  $mon_port = undef,
  $ceph_hostname
) {

  case $type {
    mon: 
      {   
        if ($mon_addr == undef) {
          fail('mon_addr is not declared')
        }

        if ($mon_addr == undef) {
          fail('mon_port is not declared')
        }

        ceph::conf::mon { $name:
          mon_addr     => $mon_addr,
          mon_port     => $mon_port,
          ceph_cluster => $ceph_cluster,
          ceph_hostname  => $ceph_hostname
        }
      }
    mds:
      {
        ceph::conf::mds { "$name":
          ceph_cluster   => "$cluster_name",
          ceph_hostname  => $ceph_hostname
        }          
      }
    default: { fail("type parameter not reconsized, only mon or mds") }
  }
}
