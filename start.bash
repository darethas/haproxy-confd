#!/bin/bash

#
# start.bash
#

[ -z "$ETCD_ADDR" ] && { echo "Need to set ETCD_ADDR"; exit 1; }

HAPROXY="/etc/haproxy"
CONFD="/etc/confd"
HAPROXY_OVERRIDE="/haproxy-override"
CONFD_OVERRIDE="/confd-override"
PIDFILE="/var/run/haproxy.pid"

CONFIG="haproxy.cfg"
ERRORS="errors"
CONF_D="conf.d"
TEMPLATES="templates"
ETCD_LOCATION="http://$ETCD_ADDR"


cd "$CONFD"

# Symlink conf.d directory
if [[ -d "$CONFD_OVERRIDE/$CONF_D" ]]; then
  mkdir -p "$CONFD_OVERRIDE/$CONF_D"
  rm -fr "$CONF_D"
  ln -s "$CONFD_OVERRIDE/$CONF_D" "$CONF_D"
fi

# Symlink templates directory
if [[ -d "$CONFD_OVERRIDE/$TEMPLATES" ]]; then
  mkdir -p "$CONFD_OVERRIDE/$TEMPLATES"
  rm -fr "$TEMPLATES"
  ln -s "$CONFD_OVERRIDE/$TEMPLATES" "$TEMPLATES"
fi

confd -node "$ETCD_LOCATION"

cd "$HAPROXY"

# Symlink errors directory
if [[ -d "$HAPROXY_OVERRIDE/$ERRORS" ]]; then
  mkdir -p "$HAPROXY_OVERRIDE/$ERRORS"
  rm -fr "$ERRORS"
  ln -s "$HAPROXY_OVERRIDE/$ERRORS" "$ERRORS"
fi

# Symlink config file.
if [[ -f "$HAPROXY_OVERRIDE/$CONFIG" ]]; then
  rm -f "$CONFIG"
  ln -s "$HAPROXY_OVERRIDE/$CONFIG" "$CONFIG"
fi


haproxy -f /etc/haproxy/haproxy.cfg -p "$PIDFILE"
