# Configure ceph APT repository
#
# == Parameters
#
# [*release*]
#   (Optional) The ceph release name
#   Default to 'bobtail'
#
# [*apt_key_source*]
#   (Optional) The source URL of APT GPG key
#   Defaults to 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc'
#
# [*apt_key_id*]
#   (Optional) The GPG ID of Ceph key
#   Defaults to '17ED316D'
#
# [*apt_source_location*]
#   (Optional) A custom APT repository for Ceph packages
#   Defaults to 'http://ceph.com/debian-${release}/'
#
# == Dependencies
#
# none
#
# == Authors
#
#  Francois Charlier francois.charlier@enovance.com
#
# == Copyright
#
# Copyright 2012 eNovance <licensing@enovance.com>
#
class ceph::apt::ceph (
  $release                    = 'bobtail',
  $apt_key_source             = 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc',
  $apt_key_id                 = '17ED316D',
  $apt_source_location        = undef,
  $apt_key_content            = undef,
  $apt_use_static_key_content = false
) {

  if (undef == $apt_source_location) {
    $real_apt_source_location = "http://ceph.com/debian-${release}/"
  } else {
    $real_apt_source_location = $apt_source_location
  }

  if ( true == $apt_use_static_key_content ) {
    $real_apt_key_content = template('ceph/apt-gpg-key')
  } else {
    $real_apt_key_content = $apt_key_content
  }

  apt::key { 'ceph':
    key         => $apt_key_id,
    key_source  => $apt_key_source,
    key_content => $real_apt_key_content
  }

  apt::source { 'ceph':
    location => $real_apt_source_location,
    release  => $::lsbdistcodename,
    require  => Apt::Key['ceph'],
    before   => Package['ceph'],
  }
}
