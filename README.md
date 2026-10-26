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

A **GeoNode cookbook** — catalog, maps, and documents on Django and GeoServer. Fleet Docker deployment in progress: Node-1 build done with bring-up underway, Node-3 base image loaded with image pulls pending. Patterns are planned from the deployment design, not yet from verified runs. It is intended for Platform engineers who run a full geospatial catalog and map portal. Validate each pattern against your own data, software versions, and operating environment before adopting it.

## Repository role and status

**Status:** Active, public — seeding. Pattern passes land in follow-up work from fleet-verified setups; the tables below list what is planned, not what is already written.

**What this repository is:** GeoNode patterns — see the table below.

**What it contributes:** Part of the ZQM Computing geospatial portfolio. The umbrella index for the series is [geospatial-cookbooks](https://github.com/ZQM-Computing/geospatial-cookbooks).

**Standing:** This repository is maintained independently. Automated checks cover only the paths and environments configured in its workflows; they do not establish production readiness or operational certification.

## Who this is for

Platform engineers who run a full geospatial catalog and map portal.

## Prerequisites

- GeoNode via Docker Compose
- PostGIS-backed Postgres
- GeoServer for the publishing pass (see geoserver-cookbook)

## Patterns (planned)

| # | Example | What it will demonstrate |
|---|---------|--------------------------|
| 01 | `01-compose-deploy` | Deploying GeoNode with Compose and its service map |
| 02 | `02-layers` | Publishing layers and setting permissions |
| 03 | `03-maps-documents` | Composing maps and attaching documents |
| 04 | `04-geoserver-pairing` | How GeoNode drives GeoServer publishing |

## Repository layout

```text
geonode-cookbook/
├── examples/          # pattern passes, landing in follow-up work
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
