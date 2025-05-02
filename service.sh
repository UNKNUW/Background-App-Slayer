#!/system/bin/sh

MODDIR=${0%/*}
CONFIG_DIR="$MODDIR/list/"
MODE_FILE="$MODDIR/config_mode/mode.txt"
LOG_FILE="/data/adb/modules/appslayer/log/appslayer_log.txt"
LAST_LOG="/data/adb/modules/appslayer/log/.appslayer_lastlog"

[ ! -f "$LOG_FILE" ] && echo "[AppSlayer] Service started" > "$LOG_FILE"
[ ! -f "$LAST_LOG" ] && date +%s > "$LAST_LOG"

[ -f "$CONFIG_DIR/gamelist.txt" ] && dos2unix "$CONFIG_DIR/gamelist.txt" 2>/dev/null
[ -f "$CONFIG_DIR/Extreme.txt" ] && dos2unix "$CONFIG_DIR/Extreme.txt" 2>/dev/null
[ -f "$CONFIG_DIR/whitelist.txt" ] && dos2unix "$CONFIG_DIR/whitelist.txt" 2>/dev/null

while true; do
    GAMELIST=$(cat "$CONFIG_DIR/gamelist.txt")
    current_time=$(date +%s)
    last_logged=$(cat "$LAST_LOG")
    if [ $((current_time - last_logged)) -ge 600 ]; then
        echo "[AppSlayer] Log auto-cleared at $(date '+%A %H:%M:%S')" > "$LOG_FILE"
        date +%s > "$LAST_LOG"
    fi

    MODE=1
[ -f "$MODE_FILE" ] && MODE=$(cat "$MODE_FILE" | tr -d '\n')

case $MODE in
    1) MODE_NAME="NORMAL" ;;
    2) MODE_NAME="AGGRESSIVE" ;;
    3) MODE_NAME="EXTREME" ;;
    *) MODE_NAME="NOT_FOUND" ;;
esac

    FG_PKG=$(dumpsys window | grep -E 'mCurrentFocus' | grep -oE '[a-zA-Z0-9._]+/[a-zA-Z0-9._]+' | cut -d/ -f1)
    if [ -z "$FG_PKG" ]; then sleep 5; continue; fi
    echo "[Check] Foreground Package: $FG_PKG" >> "$LOG_FILE"
if echo "$GAMELIST" | grep -Fxq "$FG_PKG"; then
    echo "[+] Foreground app matched gamelist: $FG_PKG" >> "$LOG_FILE"
    echo "[MODE DETECTED] Mode $MODE ($MODE_NAME)" >> "$LOG_FILE"
    am broadcast -a com.appslayer.SHOW_TOAST \
  --es msg "Mode $MODE ($MODE_NAME) Aktif"
        case "$MODE" in
            1)
                for pkg in $(pm list packages -3 | cut -d: -f2); do
                    skip=0
                    for entry in $(cat "$CONFIG_DIR/gamelist.txt" "$CONFIG_DIR/whitelist.txt"); do
                        if [[ "$pkg" == "$entry" || "$pkg" == "$entry:"* ]]; then skip=1; break; fi
                    done
                    [ "$pkg" = "$FG_PKG" ] && skip=1
                    [ "$skip" = 1 ] && continue
                    echo "[KILL:NORMAL] $pkg" >> "$LOG_FILE"
                    am trim-memory "$pkg" COMPLETE
                    [ -n "$(pidof $pkg)" ] && am force-stop "$pkg"
                done
                echo "[CLEAR_CACHE] 🗑️ Mode 1 (page cache only) SUCCESS" >> "$LOG_FILE"
                sync && echo 1 > /proc/sys/vm/drop_caches
                ;;
            2)
                for pkg in $(pm list packages -3 | cut -d: -f2); do
                    skip=0
                    for entry in $(cat "$CONFIG_DIR/gamelist.txt" "$CONFIG_DIR/whitelist.txt"); do
                        if [[ "$pkg" == "$entry" || "$pkg" == "$entry:"* ]]; then skip=1; break; fi
                    done
                    [ "$skip" = 1 ] && continue
                    echo "[KILL:AGGRESSIVE] $pkg" >> "$LOG_FILE"
                    am trim-memory "$pkg" COMPLETE
                    [ -n "$(pidof $pkg)" ] && am force-stop "$pkg"
                done
                echo "[CLEAR_CACHE] 🗑️ Mode 2 (dentries + inodes) SUCCESS" >> "$LOG_FILE"
                sync && echo 2 > /proc/sys/vm/drop_caches
                ;;
            3)
                # Kill USER apps
                for pkg in $(pm list packages -3 | cut -d: -f2); do
                    skip=0
                    for entry in $(cat "$CONFIG_DIR/gamelist.txt" "$CONFIG_DIR/Extreme.txt"); do
                        if [[ "$pkg" == "$entry" || "$pkg" == "$entry:"* ]]; then skip=1; break; fi
                    done
                    [ "$pkg" = "$FG_PKG" ] && skip=1
                    [ "$skip" = 1 ] && continue
                    echo "[KILL:EXTREME] $pkg" >> "$LOG_FILE"
                    am force-stop "$pkg"
                done
                # Kill SYSTEM apps
                for pkg in $(pm list packages -s | cut -d: -f2); do
                    skip=0
                    for entry in $(cat "$CONFIG_DIR/gamelist.txt" "$CONFIG_DIR/Extreme.txt"); do
                        if [[ "$pkg" == "$entry" || "$pkg" == "$entry:"* ]]; then skip=1; break; fi
                    done
                    [ "$pkg" = "$FG_PKG" ] && skip=1
                    if [[ "$pkg" == *systemui* || "$pkg" == *inputmethod* || "$pkg" == *keyboard* || "$pkg" == *telephony* || "$pkg" == *ims* || "$pkg" == *settings* || "$pkg" == *nfc* || "$pkg" == *bluetooth* || "$pkg" == *media* || "$pkg" == *overlay* || "$pkg" == *documentsui* || "$pkg" == *externalstorage* || "$pkg" == *shell* || "$pkg" == *packageinstaller* || "$pkg" == *telecom* || "$pkg" == *wifi* || "$pkg" == *calllog* || "$pkg" == *downloads* || "$pkg" == *frameworks* || "$pkg" == *contact* || "$pkg" == *calendar* || "$pkg" == *location* || "$pkg" == *camera* || "$pkg" == *permissioncontroller* || "$pkg" == *qti* || "$pkg" == *qualcomm* || "$pkg" == *maps* || "$pkg" == *vendor* || "$pkg" == *lineageos* || "$pkg" == *omnirom* || "$pkg" == *libremobileos* ]]; then skip=1; fi
                    [ "$skip" = 1 ] && continue
                    echo "[KILLING_APP_SYSTEM] 🔪: $pkg" >> "$LOG_FILE"
                    am trim-memory "$pkg" COMPLETE
                    rm -rf /data/data/"$pkg"/cache/*
                    for i in 1 2 3; do
                        if [ -n "$(pidof $pkg)" ]; then
                            echo "[ROUND $i] 🤜FIGHT!!! : $pkg" >> "$LOG_FILE"
                            am force-stop "$pkg"
                            sleep 1
                        else
                            echo "[KILL_SUCCESS] ✅: $pkg☠️" >> "$LOG_FILE"
                            break
                        fi
                    done
                    if [ -n "$(pidof $pkg)" ]; then
                        echo "[DAMN_TO_STRONG]: FUCK🖕🏻$pkg" >> "$LOG_FILE"
                    fi
                done
                echo "[CLEAR_CACHE] 🗑️ Mode 3 (full drop) SUCCESS" >> "$LOG_FILE"
                sync && echo 3 > /proc/sys/vm/drop_caches
                ;;
        esac
    fi

    sleep 30
done