haproxy-confd
=============

Dockerfile for haproxy and confd. Currently using this in additon to progrium/registrator for service discovery on CoreOS

You can mount an override directory for haproxy and confd.

You must pass the etcd peer address with the `-e` flag in `docker run` so that it can connect to your etcd cluster.

ex: `docker run -e "ETCD_ADDR=127.0.0.1:4001" treehau5/haproxy-confd`

Pass an override directory with the `-v` flag in the `docker run` command.

For examples of this, see [github.com/dockerfile/haproxy](dockerfile/haproxy)
