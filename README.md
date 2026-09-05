# Bulk Share Toggle (Unraid plugin)

Adds a **Shares → Bulk Share Toggle** tab with a checkbox next to every
user share, plus three buttons:

- **Share (SMB)** — set selected shares to Export = Yes
- **Share Hidden** — set selected shares to Export = Yes (hidden)
- **Unshare (SMB)** — set selected shares to Export = No

Tick as many shares as you want and click one button to apply it to all
of them, instead of opening each share's Settings tab one at a time.

Copyright © 2026 Ray Munro. Licensed under the [GNU GPLv3](LICENSE).

## How it works

The page POSTs to `/update.htm` with `shareName`, `shareExport`,
`shareSecurity` and `changeShareSecurity=Apply` for each selected share,
one at a time. This is the exact same request Unraid's own SMB Security
Settings tab sends (it's what powers the built-in "Write settings to..."
clone feature) — the plugin doesn't write to any config file itself, it
just drives Unraid's normal share-update path repeatedly. Each share's
existing Security mode (Public/Secure/Private) is read and re-sent
unchanged so it isn't reset.

Only the SMB Export setting is touched — NFS export, security mode, and
everything else are left alone.

Since it relies on an internal endpoint rather than a documented API,
a future Unraid release could change its behavior. Try it on one or two
shares first after installing, and again after any major Unraid upgrade.

## Install on Unraid

**Via Community Applications:** search for "Bulk Share Toggle" in the Apps
tab and click Install.

**Manually, from this repo:** in the Unraid webGUI go to
**Plugins → Install Plugin** and paste:

```
https://raw.githubusercontent.com/RayMunro/unraid-bulk-share-toggle/main/bulk-share-toggle.plg
```

or from the terminal:

```bash
plugin install https://raw.githubusercontent.com/RayMunro/unraid-bulk-share-toggle/main/bulk-share-toggle.plg
```

Either way, the `.plg` downloads the packaged `.txz` from this repo's
[Releases](https://github.com/RayMunro/unraid-bulk-share-toggle/releases)
and verifies it against a checksum baked into the `.plg` before installing —
no manual file copying required. Since the `.plg` ends up on the flash
drive, Unraid reinstalls the plugin automatically on every boot, same as
any other plugin. Once installed, go to **Shares → Bulk Share Toggle**.

## Uninstall

From Settings → Plugins, remove "bulk-share-toggle" normally, or run:

```bash
plugin remove bulk-share-toggle.plg
```

## Build

Requires `tar` with xz support (stock on macOS/Linux). From this
directory:

```bash
./build.sh
```

This produces `bulk-share-toggle-<version>.txz` and prints its SHA256.

## Releasing a new version

1. Bump `&version;` in `bulk-share-toggle.plg` and `VERSION` in
   `build.sh` to the same new value, and add a `<CHANGES>` entry.
2. Run `./build.sh` to produce the new `.txz` and its SHA256.
3. Create a GitHub Release tagged with the exact version string, and
   upload the `.txz` as a release asset — `&packageURL;` in the `.plg`
   points at `releases/download/<version>/<file>`.
4. Put the printed SHA256 into `&packageSHA256;` in the `.plg`.
5. Commit and push. `pluginURL` always points at `main`, so Unraid's
   "check for updates" picks up the new version from the pushed `.plg`.
