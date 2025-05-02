#!/system/bin/sh
MODDIR=${0%/*}
MODEFILE=$MODDIR/config_mode/mode.txt

# Ambil mode dari file
if [ -f "$MODEFILE" ]; then
  MODE=$(cat "$MODEFILE")
else
  MODE="Belum disetel"
fi

# Tentukan nama mode
case "$MODE" in
  1) MODENAME="Normal" ;;
  2) MODENAME="Aggressive" ;;
  3) MODENAME="Extreme" ;;
  *) MODENAME="TIDAK DIKETAHUI" ;;
esac

# Tampilkan info
echo "======== BACKGROUND APP SLAYER INFO ========"
echo "Mode saat ini : $MODE ($MODENAME)"
echo "Tanggal       : $(date '+%A, %d %B %Y')"
echo "Waktu         : $(date '+%H:%M:%S')"
echo "Device        : $(getprop ro.product.system.device)"
echo "Versi Android : $(getprop ro.build.version.release) (SDK $(getprop ro.build.version.sdk))"
echo "ROM           : $(getprop ro.build.display.id)"
echo "============================================"
