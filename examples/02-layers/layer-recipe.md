# Layer publishing recipe (admin-UI flow)

1. Sign in as a user with upload permission (never as a shared admin account if a personal account exists).
2. Upload the dataset: choose the file(s), confirm the detected format and CRS, and give the layer a descriptive title.
3. Wait for the catalog entry to appear with a thumbnail. If it does not appear, stop: check the GeoServer publish step (see 04-geoserver-pairing) before uploading again — duplicate uploads create duplicate stores.
4. Open the layer's permissions panel and set grants explicitly:
   - View: who may see the layer page and map preview.
   - Download: who may fetch the underlying data (default-deny for anonymous is the safe start).
   - Edit: who may restyle or replace data (owner only, unless a working group needs it).
   - Manage: owner only.
5. Save, then verify in a fresh anonymous browser session (not the admin's session): the layer is visible exactly as granted, no more.
6. Record the layer's catalog URL and its GeoServer layer name together — one without the other is half a reference.

## Checks that catch the common failures

- Catalog entry present + thumbnail rendered + anonymous view matches grants = published correctly.
- Catalog entry present + no thumbnail = rendering or GeoServer availability issue; check the GeoServer layer before re-uploading.
- Anonymous user sees more than granted = a permission or caching problem; re-check grants and re-verify anonymously.
