SKIPUNZIP=0

MODDIR=${0%/*}
CMS2026_DIR="/data/local/cms2026"
CLI_SOURCE="$MODDIR/bin/cms2026"

ui_print "*******************************"
ui_print "   CMS-2026 Encryption Module  "
ui_print "   Version 2.0.0             "
ui_print "   GitHub @clcwpqi            "
ui_print "*******************************"
ui_print "- Installing WebUI components..."

if [ -f "$CLI_SOURCE" ]; then
    ui_print "- Installing CLI tool..."
    
    if [ ! -d "$CMS2026_DIR" ]; then
        mkdir -p "$CMS2026_DIR"
        chmod 755 "$CMS2026_DIR"
    fi
    
    if [ ! -d "/data/local/bin" ]; then
        mkdir -p /data/local/bin
        chmod 755 /data/local/bin
    fi
    
    cp -f "$CLI_SOURCE" "$CMS2026_DIR/cms2026_bin"
    chmod 755 "$CMS2026_DIR/cms2026_bin"
    
    if [ ! -L "/data/local/bin/cms2026" ]; then
        ln -sf "$CMS2026_DIR/cms2026_bin" /data/local/bin/cms2026
        chmod 755 /data/local/bin/cms2026
    fi
    
    ui_print "- CLI installation complete!"
fi

ui_print "- Installation Complete!"
ui_print "*******************************"
ui_print "- Usage: cms2026 -e 'text' -p 'password'"
ui_print "- Or open WebUI for graphical interface"
ui_print "*******************************"
