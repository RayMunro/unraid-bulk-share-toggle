#!/bin/bash
# Builds bulk-share-toggle-<version>.txz from src/, matching the version
# baked into bulk-share-toggle.plg (&version; entity).
set -euo pipefail
cd "$(dirname "$0")"

VERSION="2026.09.14"
NAME="bulk-share-toggle"
OUT="${NAME}-${VERSION}.txz"

rm -f "$OUT"
tar -cJf "$OUT" -C src .

echo "Built $OUT"
echo "SHA256: $(shasum -a 256 "$OUT" | awk '{print $1}')"
echo ""
echo "Next steps to publish a new version:"
echo "1. Bump VERSION here and &version; in ${NAME}.plg to the same new value."
echo "2. Rebuild, then create a GitHub Release tagged \$VERSION on the repo and"
echo "   upload $OUT as a release asset (this is what &packageURL; in the .plg points to)."
echo "3. Put the SHA256 printed above into &packageSHA256; in ${NAME}.plg."
echo "4. Commit and push the updated .plg (pluginURL always points at main, so"
echo "   Unraid's update checker picks up the new version automatically)."
