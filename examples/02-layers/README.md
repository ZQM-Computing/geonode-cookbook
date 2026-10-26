# 02 — Publishing layers and setting permissions

> **Design-only, gate 1 target** — drafted from fleet evidence, not runtime-validated. Run it against your own GeoNode before adopting it.

The layer lifecycle in GeoNode: upload data → GeoNode registers a layer → GeoServer publishes it → permissions decide who sees it. This pattern walks the admin-UI flow (no API path is asserted — those spellings are validation items) and gives a permissions matrix to copy.

## Files

- `layer-recipe.md` — the step-by-step recipe with the permissions matrix.

## Recipe (summary; full steps in layer-recipe.md)

1. Upload a dataset (GeoJSON/Shapefile/GeoTIFF) through the GeoNode upload flow.
2. Confirm the layer appears in the catalog with its thumbnail and metadata.
3. Set permissions before sharing the link: owner, authenticated users, anonymous users — view, download, edit, manage as separate grants.
4. Verify as an anonymous browser session: the layer is visible exactly as the permissions say, no more.

## Permissions matrix (copy this shape, not these exact grants)

| Grant | Owner | Authenticated | Anonymous |
|---|---|---|---|
| View | yes | per-layer decision | per-layer decision (default: no) |
| Download | yes | per-layer decision | per-layer decision (default: no) |
| Edit | yes | no (unless a working group needs it) | no |
| Manage | yes | no | no |

Default-deny for anonymous download is the safe starting point; opening it is a deliberate decision per layer, not a global toggle.

## Versions note

- Fleet evidence: Node-1 GeoNode verified serving via its SITEURL host (8083 → 443); Node-3 GeoNode NOT installed.
- GeoNode version and the exact upload/API endpoint spellings are validation items — the recipe uses the admin UI flow so it does not depend on them.

## Failure behavior

- A layer that uploads but never appears in the catalog usually means the GeoServer publish step failed — check the GeoServer side (see 04-geoserver-pairing) before re-uploading.
- Permissions that look right in the admin but wrong anonymously usually mean a cached session: verify in a fresh anonymous browser session, not the admin's session.
- A thumbnail that never renders is a rendering/availability signal, not proof the data is absent — check the layer's data link first.

## To confirm at validation

- Exact upload and REST API endpoint spellings on the fleet's GeoNode version.
- The fleet's real permission defaults (the matrix above is a recommended shape, not a fleet record).
- How GeoNode's GeoServer store naming works for uploaded layers (store/layer name derivation).
