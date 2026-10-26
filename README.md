# GeoNode Cookbook

<!-- ZQM-START -->
<!-- markdownlint-disable MD033 -->
<p align="center">
  <strong>ZQM Computing — Geospatial Engineering & Scientific Computing</strong><br>
  <a href="https://github.com/ZQM-Computing">ZQM Computing</a>
</p>
<!-- markdownlint-enable MD033 -->
<!-- ZQM-END -->

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

A **GeoNode cookbook** — catalog, maps, and documents on Django and GeoServer. Fleet evidence is Node-1 only: the Compose stack there is verified serving via its SITEURL host (nginx 8083 → HTTPS 443), while Node-3 GeoNode is NOT installed (Docker resume pending). Patterns are drawn from the Node-1 deployment. It is intended for Platform engineers who run a full geospatial catalog and map portal. Validate each pattern against your own data, software versions, and operating environment before adopting it.

## Repository role and status

**Status:** Active, public — first pattern pass written (design-only, gate 1 target; runtime validation pending).

**What this repository is:** GeoNode patterns — see the table below.

**What it contributes:** Part of the ZQM Computing geospatial portfolio. The umbrella index for the series is [geospatial-cookbooks](https://github.com/ZQM-Computing/geospatial-cookbooks).

**Standing:** This repository is maintained independently. Automated checks cover only the paths and environments configured in its workflows; they do not establish production readiness or operational certification.

## Who this is for

Platform engineers who run a full geospatial catalog and map portal.

## Prerequisites

- GeoNode via Docker Compose
- PostGIS-backed Postgres
- GeoServer for the publishing pass (see geoserver-cookbook)

## Patterns

| # | Example | Status | What it demonstrates |
|---|---------|--------|----------------------|
| 01 | [01-compose-deploy](examples/01-compose-deploy/README.md) | Written | Deploying GeoNode with Compose and its service map |
| 02 | [02-layers](examples/02-layers/README.md) | Written | Publishing layers and setting permissions |
| 03 | [03-maps-documents](examples/03-maps-documents/README.md) | Written | Composing maps and attaching documents |
| 04 | [04-geoserver-pairing](examples/04-geoserver-pairing/README.md) | Written | How GeoNode drives GeoServer publishing |

## Repository layout

```text
geonode-cookbook/
├── examples/01-compose-deploy/
├── examples/02-layers/
├── examples/03-maps-documents/
├── examples/04-geoserver-pairing/
├── README.md
└── LICENSE
```

## Roadmap

- First pattern pass: the first two table rows
- Second pass: the remaining rows, from fleet-verified setups

## Contributing

A contributing guide lands with the first pattern pass. Report security issues to <zqmcomputing@gmail.com> — please do not open a public issue for those.

## More from this series

- [geoserver-cookbook](https://github.com/ZQM-Computing/geoserver-cookbook) — Publishing, styling, federation, and securing OGC services
- [geonetwork-cookbook](https://github.com/ZQM-Computing/geonetwork-cookbook) — Spatial metadata catalogs, harvesting, and CSW search
- [postgis-cookbook](https://github.com/ZQM-Computing/postgis-cookbook) — Spatial indexing, joins & KNN, SRID management, vector tiles

