#!/usr/bin/env bash

if [ -z "$1" ]; then
    bash
    exit 0
fi

case "$1" in
"refbox")
    $REFBOX_DIR/bin/refbox
    exit 0
    ;;
"controller")
    $REFBOX_DIR/bin/atwork-controller
    exit 0
    ;;
"viewer")
    $REFBOX_DIR/bin/atwork-viewer
    exit 0
esac

exec $@
