## V5.1.2
### Apa yang baru?

- ✅ **Menambahkan informasi total aplikasi yang telah dibersihkan.**

- 🚀 **Fitur baru: ExtraKill**  
  - Menggunakan file `listkill.txt` untuk menentukan daftar paket aplikasi yang ingin dibersihkan, seperti Play Store, Google Kesehatan, dll.  
  - Secara default, `listkill.txt` sudah berisi beberapa aplikasi Google yang dianggap tidak terlalu penting.  
  - Silakan hapus package name yang menurutmu penting dan tambahkan aplikasi lain sesuai kebutuhan.

- 🧹 **Perubahan pada `DROP_CACHE`**  
  - Kini berlaku sama di semua mode, untuk memastikan cache pada RAM benar-benar dibersihkan.

- 🔔 **Penambahan notifikasi dan toast**  
  - Muncul setelah proses eksekusi selesai.

- 🎮 **Daftar game (`gamelist.txt`) diperbarui**  
  - Beberapa game populer sudah didaftarkan.  
  - Jika game kamu belum terdaftar, silakan tambahkan sendiri secara manual.

## v5.1.1
- Fix Notifikasi 
- Fix Tombol Eksekusi sekarang 
- Fix Delay Kill App
- Improved Performance 
- Fix Crash saat eksekusi mode Extreme

## V5.1.0
- Ditambahkan tombol "Eksekusi Sekarang" di aplikasi, memungkinkan pengguna menjalankan mode saat ini secara langsung, tanpa menunggu deteksi game.
- Aplikasi kini akan menampilkan notifikasi jika versi baru tersedia, dan mendukung proses update langsung dari dalam aplikasi.
- Untuk di MODE 2 (AGRESIF) pemilihan governor kini menggunakan governor userspace dengan mengatur 75% dari frekuensi maksimum kernel. Jika userspace tidak tersedia di kernel, sistem akan otomatis menggunakan performance, 
Hal ini menggantikan governor interactive yang tidak selalu tersedia di semua kernel.
### Cara cek governor apa aja yang tersedia di kernel melalui Termux:
```
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
```
- Modul kini tidak hanya otomatis, tapi juga memberi kendali manual dan update yang informatif.

## V5.0.7 :
- ⚙️ Optimalisasi Proses:
Kini proses kill app hanya dijalankan saat aplikasi foreground berubah, bukan terus-menerus seperti sebelumnya. Lebih efisien dan ringan!
- 🔋 Hemat Baterai:
Waktu jeda antar pengecekan foreground dikembalikan jadi 30 detik yang sebelumnya 90 detik. Lebih responsif dan tetap hemat daya!
- 🧹 Perbaikan Minor:
Semua file list otomatis diubah ke format Unix dengan dos2unix agar tidak terjadi kesalahan baca.
- ✅ Dah itu aja sih

## V5.0.6
- Penyesuaian mekanisme shell agar lebih ringan dan stabil di berbagai perangkat.
- Interval loop skrip diperpanjang dari 30 detik menjadi 90 detik untuk efisiensi daya dan kinerja.
- Penambahan fallback saat proses kill gagal untuk menghindari force stop yang tidak perlu.
- Sinkronisasi dengan aplikasi AppSlayer untuk menampilkan status mode dan hasil eksekusi secara real-time.
- Dukungan penuh untuk Android 10 ke atas.
- Instalasi sekarang lebih simpel. Cukup flash modul lewat Magisk, lalu tekan action button, dan aplikasi akan otomatis terpasang. Enggak perlu ribet install manual lagi.
- Buat kamu yang pakai Mode Extreme dan nemuin aplikasi jadi error atau force-close, Jalankan perintah ini di Termux:
```
su
pm list packages -f | sed 's/package://g' > /sdcard/list.txt
```
- Kirim file list.txt ke grup. Nanti saya akan cek dan tambahkan ke daftar Extreme.txt, biar ke depannya lebih aman dan stabil.

## V5.0.5
### 🎉 Apa yang Baru?
- Rilis publik perdana Background App Slayer (BAS)!
- Konfigurasi full pakai file teks. Gak ribet, tinggal edit aja.
- Auto bunuh aplikasi latar belakang pas kamu buka game.
- Dukungan penuh untuk Magisk, KernelSU, dan KSU Next.
- Ringan dan cepat, tapi tetap fleksibel.

### 🔧 Cara Instalasi
1. Flash modul via Magisk / KernelSU / KSU Next.
2. Reboot HP kamu.
3. Masuk ke folder `/data/adb/modules/appslayer/` dan atur:
   - `mode.txt` → isi dengan angka 1 / 2 / 3
   - `gamelist.txt` → isi dengan package game yang kamu mainkan
   - `whitelist.txt` → aplikasi yang gak boleh ditutup
   - `extreme.txt` → aplikasi yang ingin kamu lindungi saat pakai Mode 3

### ⚠️ Peringatan Penting
- Jangan hapus isi default `extreme.txt`, itu buat jaga sistem kamu tetap stabil!
- Mode 3 itu ganas banget, pake cuma pas butuh RAM longgar buat game berat.

### 🧠 Catatan Buat Kamu
> Modul ini bukan jimat anti lemot. Gunakan dengan bijak ya.  
> Kalau ada error, bug, atau malah HP jadi ngambek, ya tanggung sendiri.  
> Tapi kalau butuh bantuan atau mau lapor bug, langsung gas ke grup: [Telegram](https://t.me/unknuwprojects)

--- 
