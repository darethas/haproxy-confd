haproxy-confd
=============

Dockerfile for haproxy and confd. Currently using this in additon to progrium/registrator for service discovery on CoreOS

You can mount an override directory for haproxy and confd.

You must pass the etcd peer address with the `-e` flag in `docker run` so that it can connect to your etcd cluster.

ex: `docker run -e "ETCD_ADDR=127.0.0.1:4001" treehau5/haproxy-confd`

Pass an override directory with the `-v` flag in the `docker run` command.

For examples of this, see [dockerfile/haproxy](http://www.github.com/dockerfile/haproxy)

### Usage

    docker run -d -e "ETCD_ADDR=127.0.0.1:4001" -p 80:80 treehau5/haproxy-confd

#### Customizing Haproxy

    docker run -d -e "ETCD_ADDR=127.0.0.1:4001" -p 80:80 -v <override-dir>:/haproxy-override dockerfile/haproxy

where `<override-dir>` is an absolute path of a directory that could contain:

  - `haproxy.cfg`: custom config file (replace `/dev/log` with `127.0.0.1`, and comment out `daemon`)
  - `errors/`: custom error responses

#### Customizing Confd

    docker run -d -e "ETCD_ADDR=127.0.0.1:4001" -p 80:80 -v <override-dir>:/confd-override dockerfile/haproxy
    
    where `<override-dir>` is an absolute path of a directory that could contain:

  - `templates/`: templates for your confd to generate based on additions to the etcd backend
  - `conf.d/`: containing your template resource configs in toml format

After few seconds, open `http://<host>` to see the haproxy stats page.
