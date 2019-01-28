#!/usr/bin/env bash

set -euo pipefail

sudo yum install -y net-tools

case "$(hostname)" in
  w2)
    route add -net 10.21.0.0/16 gw 192.168.33.21
    ;;
  w1)
    route add -net 10.22.0.0/16 gw 192.168.33.22
    ;;
  *)
    route add -net 10.21.0.0/16 gw 192.168.33.21
    route add -net 10.22.0.0/16 gw 192.168.33.22
    ;;
esac
