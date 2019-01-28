#!/usr/bin/env bash

set -euo pipefail
 
sudo yum install -y haproxy

sudo mkdir -p /run/haproxy
 
sudo cat >/etc/haproxy/haproxy.cfg <<EOF

global
	log /dev/log	local0
	log /dev/log	local1 notice
	chroot /var/lib/haproxy
	stats socket /run/haproxy/admin.sock mode 660 level admin
	stats timeout 30s
	user haproxy
	group haproxy
	daemon

	# Default SSL material locations
	ca-base /etc/ssl/certs
	crt-base /etc/ssl/private

	# Default ciphers to use on SSL-enabled listening sockets.
	# For more information, see ciphers(1SSL). This list is from:
	#  https://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/
	ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AESGCM:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS
	ssl-default-bind-options no-sslv3

defaults
	log	global
	mode	tcp
	option	tcplog
	option	dontlognull
     timeout connect 5000
     timeout client  50000
     timeout server  50000

frontend k8s
	bind *:6443
	default_backend k8s_backend

backend k8s_backend
	balance roundrobin
	mode tcp
	server c0 192.168.33.11:6443 check inter 1000
	server c1 192.168.33.12:6443 check inter 1000
EOF

sudo setsebool -P haproxy_connect_any=1
sudo systemctl restart haproxy