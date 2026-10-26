# 01 — Deploying GeoNode with Compose and its service map

> **Design-only, gate 1 target** — drafted from fleet evidence, not runtime-validated. Run it against your own stack before adopting it.

GeoNode is a Compose stack, not a single container. This pattern gives the service map, the `.env` keys that matter, the CRLF trap the fleet actually hit, and the only valid health probe.

## Files

- `env.sample` — the `.env` keys from the fleet's Node-1 deployment (placeholders for secrets).
- `check.sh` — the health probe. Read its header before running it: it probes the SITEURL host, never localhost.

## Service map (Node-1, verified states after the Docker restart)

| Service | Role | Fleet-verified state |
|---|---|---|
| django | GeoNode app (Django) | Up, healthy |
| nginx | TLS + routing frontend | Up, healthy |
| geoserver | Publishing backend | Up, healthy (heap Xms1G/Xmx2G) |
| db | PostGIS-backed Postgres | Up, healthy |
| redis | Cache / broker | Up, healthy |
| celery | Async tasks | Up, healthy (127 restart loop cleared by the LF-fix rebuild) |
| letsencrypt | Certbot | Restarting (0) — benign: certbot cannot issue for an IP |

## The probe rule (do not skip this)

GeoNode's nginx answers **444 (close, no response)** to any request whose Host is not its configured `server_name` — the SITEURL host. A `localhost:8083` probe that "connects then closes" is the nginx rule working, NOT an outage. Probe ONLY via the SITEURL host:

```bash
SITEURL_HOST=100.106.187.108 bash check.sh
# Fleet-verified chain: http://<host>:8083/ -> 302 -> https://<host>:443/ -> 200
```

## The CRLF trap (fleet evidence, twice)

Windows git checkouts write CRLF into shell scripts, and GeoNode's entrypoints break on it. The fleet fixed it twice: first `entrypoint.sh` + 7 `.sh` files, then `celery-cmd` plus extensionless/`.py`/`.ini`/`.toml`/`.txt`/`.cfg`/`.yaml`/`.yml`/`.json` files under `src/`. Any GeoNode deploy from a Windows checkout needs an LF pass over those paths before `compose up` — or the failure looks like a container defect when it is a line-ending defect.

## Versions note

- Fleet evidence: Node-1 Compose project (`C:\docker-stacks\geonode`, `geonode-project`), Docker 29.6.1, HTTP 8083 / HTTPS 443, `SITEURL http://100.106.187.108:8083/`, `LETSENCRYPT_MODE=disabled`, GeoServer heap Xms1G/Xmx2G (reduced from 4G/4G, inspect-verified live).
- GeoNode version itself: not in the fleet record used here — to confirm at validation, never guessed.
- Node-3 GeoNode is NOT installed (Docker resume pending); these patterns scope to Node-1 evidence only.

## Failure behavior

- `letsencrypt` Restarting (0) is benign and expected for an IP-based SITEURL. Do not chase it.
- A celery Restarting (127) loop before the LF fix was a line-ending defect, not a code defect — check line endings before debugging the task code.
- The engine wedging (Node-1, October 2026) took all published-port traffic down at once; if every container's port fails together, suspect the Docker engine before GeoNode.

## To confirm at validation

- The GeoNode version and the bundled GeoServer version in the Compose images.
- The full `.env` key list (the sample here covers only the keys the fleet record names).
- Firewall rules for 8083/443 (the 8083 rule exists; the 443 rule was unverified in the record).
