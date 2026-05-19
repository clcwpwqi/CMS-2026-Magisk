#!/system/bin/sh
# CMS-2026 Service Script
# Version: 2.0.0

MODDIR=${0%/*}
CMS2026_DIR="/data/local/cms2026"
CLI_SOURCE="$MODDIR/bin/cms2026"
CLI_TARGET="/data/local/bin/cms2026"
ALTERNATIVE_TARGET="/system/bin/cms2026"

setup_cli() {
    if [ ! -d "/data/local/bin" ]; then
        mkdir -p /data/local/bin
        chmod 755 /data/local/bin
    fi
    
    if [ ! -d "$CMS2026_DIR" ]; then
        mkdir -p "$CMS2026_DIR"
        chmod 755 "$CMS2026_DIR"
    fi
    
    if [ -f "$CLI_SOURCE" ]; then
        cp -f "$CLI_SOURCE" "$CMS2026_DIR/cms2026_bin"
        chmod 755 "$CMS2026_DIR/cms2026_bin"
        
        if [ ! -f "$CLI_TARGET" ]; then
            ln -sf "$CMS2026_DIR/cms2026_bin" "$CLI_TARGET"
            chmod 755 "$CLI_TARGET"
        fi
        
        if [ -f "$CLI_TARGET" ]; then
            chmod 755 "$CLI_TARGET"
        fi
    fi
}

if [ -f "$CLI_SOURCE" ]; then
    setup_cli
fi
