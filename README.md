![Background-App-Slayer logo](./LOGO.png)

# Background App Slayer (BAS)

**Modul Magisk pembasmi aplikasi latar belakang otomatis.**  
Versi ini adalah pembaruan besar dari proyek [SmartAppClose](http://github.com/UNKNUW/SmartAppClose) lama.

## ✨ Deskripsi Modul

Background App Slayer (BAS) membantu kamu mendapatkan performa maksimal dan menghemat baterai saat bermain game.  
Dengan cara menutup aplikasi-aplikasi latar belakang secara otomatis saat game dijalankan.  
Dirancang modular agar mudah disesuaikan hanya dengan edit file teks, tanpa perlu termux atau coding ulang.

## ⚙️ Fitur Unggulan

- Auto-kill aplikasi background saat game aktif.
- 3 Mode kerja:
  - `1` **Normal** – ringan dan aman.
  - `2` **Aggressive** – lebih banyak aplikasi ditutup.
  - `3` **Extreme** – semua dibantai (termasuk app sistem yang ga penting) KECUALI list extreme.txt
- Konfigurasi lewat file teks:
  - `gamelist.txt` – daftar game yang memicu aksi.
  - `whitelist.txt` – aplikasi yang tidak akan ditutup.
  - `extreme.txt` – daftar aplikasi yang akan dilindungi di Mode 3.
  - `mode.txt` – menentukan mode kerja (1, 2, 3).
- Logging aktivitas di `/data/adb/modules/appslayer/log/`
- Ringan, fleksibel, tidak perlu reboot saat ganti konfigurasi.
- Action Button di Magisk/KSU Manager untuk cek status mode dan sistem.

## 🆚 Perbandingan dengan SmartAppClose

| Fitur | SmartAppClose | BAS v5.0.5 |
|-------|----------------|------------|
| Mode kerja | ❌ Tidak ada | ✅ Ada 3 mode |
| Modular | ❌ | ✅ |
| Logging | Minimal | Lengkap |
| Fleksibilitas | Rendah | Tinggi |
| User friendly | Cukup | ✅ Sangat |

## 🛠️ Cara Install

1. **Install via Magisk Manager / KernelSU / KSU Next**
   - Buka Magisk > Modules > Install from storage
   - Pilih ZIP dari modul BAS
   - Reboot

2. **Atur Konfigurasi:**
   - Buka folder `/data/adb/modules/appslayer/`
   - Edit file:
     - `mode.txt` → isi `1`, `2`, atau `3`
     - `gamelist.txt` → isi dengan nama package game
     - `whitelist.txt` → aplikasi penting yang wajib hidup
     - `extreme.txt` → aplikasi yang akan DILINDUNGI di mode 3

## ⚠️ Penting Tentang Mode Extreme

Mode 3 (Extreme) akan menutup semua aplikasi **kecuali** yang ada di `extreme.txt`.  
JANGAN hapus isi default file tersebut — itu bisa membuat SISTEM ERROR dan FREEZE 

Kalau ingin menambahkan aplikasi untuk dilindungi:
- Tambahkan di **baris paling atas** atau **paling bawah** file `extreme.txt`.

## 🚨 Peringatan

- Gunakan **sesuai kebutuhan**, terutama untuk Mode 3.
- Jangan aktifkan Mode Extreme terus-menerus, HP kamu bisa ngambek!
- Kalau ada bug, **jangan lapor ke service center**, apalagi **lapor polisi**. Lapornya ke sini saja:
  [TELEGRAM](https://t.me/unknuwprojects)

## 🤖 Untuk Users Android 11  
Jika mengalami error saat install, pakai cara yang sama seperti project sebelumnya [klik di sini](https://github.com/UNKNUW/SmartAppClose/blob/main/for_Android_11.md)

---

> **DO WITH YOUR OWN RISK**  
> Kamu tanggung sendiri kalau terjadi sesuatu.

---

**Selamat ngoprek dan semoga lancar gaming-nya!**  
_– @unknuw Projects Team_
