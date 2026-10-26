#!/bin/bash
# GeoNode health probe — SITEURL HOST ONLY, NEVER localhost.
#
# GeoNode's nginx answers 444 (close, no response) to any Host that is not
# its configured server_name (the SITEURL host). A localhost probe that
# "connects then closes" is that rule working, not an outage.
#
# Usage: SITEURL_HOST=<your SITEURL host> bash check.sh
#   e.g. SITEURL_HOST=100.106.187.108 bash check.sh
# Expected chain (fleet-verified on Node-1):
#   http://<host>:8083/ -> 302 -> https://<host>:443/ -> 200
set -u
HOST="${SITEURL_HOST:-}"
if [ -z "$HOST" ]; then
  echo "ERROR: set SITEURL_HOST to the GeoNode SITEURL host (never localhost)" >&2
  exit 2
fi
if [ "$HOST" = "localhost" ] || [ "$HOST" = "127.0.0.1" ]; then
  echo "ERROR: localhost is an invalid GeoNode probe (nginx 444s it). Use the SITEURL host." >&2
  exit 2
fi
echo "HTTP : $(curl -s -o /dev/null -w "%{http_code} -> %{redirect_url}" "http://${HOST}:8083/")"
echo "HTTPS: $(curl -sk -o /dev/null -w "%{http_code} (%{size_download} bytes)" "https://${HOST}:443/")"
