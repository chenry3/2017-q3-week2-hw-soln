# ulc-205 firewall config management
package { 'iptables-persistent':
  ensure => installed;
}

firewall { '001 accept related established rules':
  proto => 'all',
  state => ['RELATED', 'ESTABLISHED'],
  action => 'accept',
}
firewall { '002 accept all to lo interface':
  proto => 'all',
  iniface => 'lo',
  action => 'accept',
} 


# This rule will drop any NEW SSH packets if more than 3 have come in
# the last 600 seconds.  This is our Rate Limiting rule
#$IPT -A INPUT -p tcp --dport 22 -i $EXT -m state --state NEW -m recent --update --seconds 600 --hitcount 3 -j DROP
firewall {'003 SSH rate limit DROP':
  dport     => 22,
  proto     => tcp,
  state     => ['NEW'],
  recent    => 'update',
  rseconds  => 600,
  rhitcount => 3,
  action    => 'drop'
}

# This rule will flag any NEW SSH connections so we can see how many have come
#$IPT -A INPUT -p tcp --dport 22 -i $EXT -m state --state NEW -m recent --set
firewall {'004 SSH Mark NEW connections':
  dport  => 22,
  proto  => tcp,
  state  => ['NEW'],
  recent => 'set'
}

firewall { '005 Allow inbound SSH':
  dport => 22,
  proto => tcp,
  action => accept,
}
firewall { '006 Allow inbound HTTP':
  dport => 80,
  proto => tcp,
  action => accept,
}
firewall { '007 Allow inbound HTTPS':
  dport => 443,
  proto => tcp,
  action => accept,
}
firewall { '999 drop all':
  proto => 'all',
  action => 'drop',
  before => undef,
}
