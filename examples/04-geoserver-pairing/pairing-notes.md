# Pairing notes: GeoNode ↔ bundled GeoServer

## What each side owns

- GeoNode (Django + PostGIS): catalog entries, metadata, permissions, maps, documents.
- Bundled GeoServer (inside the GeoNode Compose stack): stores, layers, WMS/WFS serving, previews.
- The handoff: layer publish in GeoNode creates/updates the GeoServer store + layer.

## Diagnostic order (follow it — it prevents the classic misdiagnosis)

1. Is the catalog entry present? If no, the problem is GeoNode-side (upload/catalog).
2. Is the GeoServer store + layer present? If no, the problem is the publish handoff.
3. Does a WMS GetMap return image bytes (size > 0)? If no, the problem is GeoServer-side (health, heap, data path).
4. Do permissions match anonymously? If no, the problem is grant-side (GeoNode permissions, checked in a fresh anonymous session).

## Do-not-confuse list

- Bundled GeoServer (GeoNode stack, internal networking) vs standalone GeoServer 3.0.2 (port 8080, separate deployment).
- Catalog permissions (GeoNode) vs GeoServer security rules (separate layer; a catalog grant does not rewrite them).
- GeoNode 8083/443 (nginx frontend) vs GeoServer's internal port (not a public fleet port in this record).
