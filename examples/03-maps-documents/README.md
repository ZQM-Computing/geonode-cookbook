# 03 — Composing maps and attaching documents

> **Design-only, gate 1 target** — drafted from fleet evidence, not runtime-validated. Run it against your own GeoNode before adopting it.

A map in GeoNode is a composition of catalog layers plus its own metadata and permissions; documents attach context (reports, methods, images) to the same catalog entry. This pattern gives the composition recipe and the sharing rules.

## Files

- `map-recipe.md` — the step-by-step recipe.

## Recipe (summary; full steps in map-recipe.md)

1. Create a map from catalog layers (at least one published layer from pattern 02).
2. Set the map's extent, base layer, and layer order; save with a descriptive title and abstract.
3. Attach documents: upload or link each document to the map's catalog entry, with its own title and description.
4. Set map permissions separately from layer permissions — a viewable map does not automatically make its layers downloadable.
5. Verify as an anonymous session: the map renders, its layers draw, and documents are reachable exactly as granted.

## Sharing rules (the part people get wrong)

- Map permissions and layer permissions are independent. Sharing a map does not share its layers' data; each layer keeps its own grants (see 02).
- A document attached to a map keeps its own permissions too. Attaching a restricted document to a public map does not publish the document — but verify this anonymously anyway.
- A map link shared before permissions are set is a leak waiting for a crawler. Set permissions before sharing, every time.

## Versions note

- Fleet evidence: Node-1 GeoNode verified serving via its SITEURL host (8083 → 443); Node-3 GeoNode NOT installed.
- GeoNode version and exact composer/API spellings are validation items — the recipe uses the UI flow so it does not depend on them.

## Failure behavior

- A map that renders empty usually means a layer permission problem (the map is shared, a layer is not) — check layer grants, not the map.
- A document that 404s from the map page usually means the document's own permissions or a broken link — check the document entry directly.
- A map that saves but loses layer order usually means the save did not complete — re-open the map and confirm before sharing.

## To confirm at validation

- Exact map-composer and document-upload endpoint spellings on the fleet's GeoNode version.
- Whether the fleet's GeoNode renders layer previews through its bundled GeoServer or a separate WMS (see 04).
- The fleet's real defaults for map/document permissions (the rules above are recommended practice, not a fleet record).
