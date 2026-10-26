# Map composition recipe

1. Start from at least one published layer (pattern 02). A map with no published layers is an empty frame — publish first.
2. Add layers in draw order (basemap first, overlays after), set the initial extent to the area the map is about, and save with a title and abstract that say what the map is for.
3. Attach documents to the map's catalog entry: each document gets its own title and description (a document titled "doc1.pdf" helps no one).
4. Set map permissions explicitly, then set each layer's and document's permissions explicitly — they are independent grants (see the README's sharing rules).
5. Verify in a fresh anonymous session: the map renders, every layer draws, every document opens exactly as granted.
6. Share the map link only after step 5 passes.

## Checks that catch the common failures

- Map renders but a layer is missing = that layer's permissions, not the map's. Check the layer.
- Document link 404s = the document's permissions or a broken link. Check the document entry directly.
- Saved map loses layer order = the save did not complete. Re-open and confirm before sharing.
