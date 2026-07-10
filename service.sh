#!/system/bin/sh
# CMS-2026 Service Script
# Version: 2.0.0
#
# This script runs on boot (late_start service) to ensure
# the CLI tool is properly installed and accessible.

MODDIR=${0%/*}
CMS2026_DIR="/data/local/cms2026"
CLI_SOURCE="$MODDIR/bin/cms2026"
CLI_TARGET="/data/local/bin/cms2026"
CLI_BIN="$CMS2026_DIR/cms2026_bin"

# Ensure target directories exist
if [ ! -d "/data/local/bin" ]; then
    mkdir -p /data/local/bin
    chmod 755 /data/local/bin
fi

if [ ! -d "$CMS2026_DIR" ]; then
    mkdir -p "$CMS2026_DIR"
    chmod 755 "$CMS2026_DIR"
fi

# Install CLI binary
if [ -f "$CLI_SOURCE" ]; then
    cp -f "$CLI_SOURCE" "$CLI_BIN"
    chmod 755 "$CLI_BIN"

    # Create or fix symlink
    if [ ! -L "$CLI_TARGET" ]; then
        ln -sf "$CLI_BIN" "$CLI_TARGET"
        chmod 755 "$CLI_TARGET"
    fi

    # Ensure symlink target is correct (repair if broken)
    if [ -L "$CLI_TARGET" ]; then
        local target
        target=$(readlink "$CLI_TARGET" 2>/dev/null)
        if [ "$target" != "$CLI_BIN" ]; then
            rm -f "$CLI_TARGET"
            ln -sf "$CLI_BIN" "$CLI_TARGET"
            chmod 755 "$CLI_TARGET"
        fi
    fi
fi
