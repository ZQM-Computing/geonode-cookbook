# 04 — How GeoNode drives GeoServer publishing

> **Design-only, gate 1 target** — drafted from fleet evidence, not runtime-validated. Run it against your own stack before adopting it.

GeoNode does not serve data itself: when a layer is published, GeoNode creates the corresponding store and layer in its bundled GeoServer, and previews flow through GeoServer's OGC services. This pattern explains the handoff, the checks that prove it, and the boundaries that must not be crossed.

## The handoff (what happens on publish)

1. GeoNode registers the layer in its catalog (Django + PostGIS).
2. GeoNode creates/updates the GeoServer store and layer for that dataset.
3. GeoServer serves the layer via WMS/WFS; GeoNode's previews and downloads flow through it.
4. GeoNode permissions gate the catalog side; GeoServer's own access rules are a separate layer — a catalog grant does not rewrite GeoServer security.

## Checks that prove the pairing works

- The layer's catalog entry exists AND the same layer name answers from GeoServer (a catalog-only layer is unpublished, whatever the UI says).
- A WMS GetMap request for the layer returns image bytes (size > 0) — the byte check, not just an HTTP 200, is the proof (an error document can also be a 200).
- The GeoServer container is healthy with the fleet heap (Xms1G/Xmx2G, inspect-verified on Node-1 after the recreate) — a heap-starved GeoServer fails publishes in ways that look like GeoNode bugs.

## Boundaries (fleet decisions, not pattern choices)

- The bundled GeoServer's admin password is Alex's to change (deferred, like the standalone GeoServer admin). This pattern never states, uses, or resets it.
- The standalone GeoServer 3.0.2 tree is a different deployment from GeoNode's bundled GeoServer. Do not apply standalone-GeoServer procedures (extensions, restarts, heap changes) to the bundled one, or vice versa.
- GeoNode's GeoServer is reached through the stack's internal networking, not through the public 8080 port of the standalone GeoServer. Port confusion between the two is the classic misdiagnosis here.

## Versions note

- Fleet evidence: Node-1 GeoNode verified serving via its SITEURL host (8083 → 443); bundled GeoServer heap Xms1G/Xmx2G (reduced from 4G/4G); Node-3 GeoNode NOT installed.
- GeoNode version and bundled GeoServer version: to confirm at validation, never guessed.
- Standalone GeoServer 3.0.2 (port 8080) is a separate fleet deployment; its version does not describe the bundled one.

## Failure behavior

- Upload succeeds but the layer never previews: check the GeoServer side first (store/layer existence, container health, heap pressure) before re-uploading.
- A WMS request returning an error document with HTTP 200: check the byte size and content type, not just the status code.
- GeoServer restarts do not fix a catalog-side problem, and catalog re-publishes do not fix a GeoServer-side problem — diagnose which side failed before acting on either.

## To confirm at validation

- Bundled GeoServer version and its store/layer naming derivation for uploaded datasets.
- Exact WMS GetMap parameter spellings the fleet's bundled GeoServer expects (the pattern asserts the byte check, not a verbatim URL).
- Whether GeoNode's permission model writes anything into GeoServer security rules, or gates purely at the catalog layer.
