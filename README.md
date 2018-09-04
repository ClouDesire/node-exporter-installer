# node-exporter-installer [![CircleCI](https://circleci.com/gh/ClouDesire/node-exporter-installer.svg?style=svg)](https://circleci.com/gh/ClouDesire/node-exporter-installer)

Automatically download [node_exporter](https://github.com/prometheus/node_exporter) latest tar.gz archive, unpack and configure for automatic startup (via systemd or upstart) on various platforms, tested via [test-kitchen](https://github.com/ClouDesire/node-exporter-installer/blob/master/test-cookbook/.kitchen.yml) and [inspec](https://github.com/ClouDesire/node-exporter-installer/blob/master/test-cookbook/test/integration/default/default_test.rb):

* Ubuntu 16.04+
* Debian 9
* Centos 6+
* RHEL 6+

## Usage

```bash
curl -sSL https://cloudesire.github.io/node-exporter-installer/install.sh | sudo sh
```
