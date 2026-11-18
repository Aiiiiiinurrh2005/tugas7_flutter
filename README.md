# State Management Demo App - Flutter

Aplikasi media pembelajaran dan praktik interaktif materi Flutter tentang **State Management Dasar** menggunakan `setState()` murni (tanpa Provider, GetX, atau Bloc) dengan arsitektur Material Design 3.

---

## 🎯 Tujuan Pembelajaran
Aplikasi ini dirancang untuk mendemonstrasikan 5 pilar utama manajemen state di Flutter:
1. **Konsep State dalam Flutter & `setState()`**: Memahami bagaimana perubahan data menandai widget sebagai *dirty* dan memicu method `build()` untuk melakukan rebuild antarmuka.
2. **Widget Lifecycle**: Mengamati alur hidup widget dari `initState()`, `build()`, `didUpdateWidget()`, hingga pembersihan memori pada `dispose()`.
3. **Passing Data Between Widgets (Props Down)**: Pengiriman data satu arah dari Parent Widget ke Child Widget (`StatelessWidget`) melalui constructor parameter (`final` & `required`).
4. **Callback Function & Event Propagation (Events Up)**: Komunikasi dari Child Widget ke Parent Widget menggunakan `VoidCallback` untuk memperbarui state induk.
5. **Best Practices State Management**: Panduan praktis penulisan kode efisien (state scoping, minimalisir rebuild, pencegahan memory leak).

---

## 📱 Fitur & Modul Praktik

| Modul | Halaman | Deskripsi |
|---|---|---|
| **1. State & Counter** | `counter_page.dart` | Counter interaktif (+, -, reset) dengan visualisasi status nilai, preset step (+5, +10), serta inspektor jumlah rebuild UI secara real-time. |
| **2. Widget Lifecycle** | `lifecycle_page.dart` | Pengujian daur hidup widget dengan form input konfigurasi parent untuk memicu `didUpdateWidget()`, pembersihan `TextEditingController` di `dispose()`, serta live lifecycle log. |
| **3. Passing Data** | `passing_data_page.dart` | Form parent mengirimkan data nama dan peran ke child widget `ProfileCard` (StatelessWidget) secara dinamis. |
| **4. Callback Function** | `callback_page.dart` | Child widget `LikeButton` mengirimkan event via `VoidCallback` ke parent untuk menambah total like real-time. |
| **5. Best Practices** | `best_practices_page.dart` | Panduan interaktif 5 praktik terbaik dilengkapi contoh DO vs DON'T serta tips optimasi performa. |

---

## 🛠️ Teknologi & Spesifikasi
- **Framework**: Flutter 3.x
- **Bahasa Pemrograman**: Dart (Sound Null Safety)
- **UI Design**: Material Design 3
- **Primary Color**: `#2563EB` (Royal Blue)
- **Secondary Color**: `#DBEAFE` (Soft Blue)
- **Navigasi**: `BottomNavigationBar` (Home, Praktik, Tentang)

---

## 📂 Struktur Project

```text
lib/
├── main.dart                          # Entry point aplikasi & BottomNavigationBar
├── theme/
│   └── app_theme.dart                 # Konfigurasi Tema Material Design 3
├── widgets/
│   ├── menu_card.dart                 # Card menu pembelajaran
│   ├── profile_card.dart              # Child StatelessWidget untuk Passing Data
│   └── like_button.dart               # Child Widget untuk Callback Function
└── pages/
    ├── dashboard_page.dart            # Halaman Dashboard utama
    ├── counter_page.dart              # Modul 1: State & Counter
    ├── lifecycle_page.dart            # Modul 2: Widget Lifecycle
    ├── passing_data_page.dart         # Modul 3: Passing Data
    ├── callback_page.dart             # Modul 4: Callback Function
    ├── best_practices_page.dart       # Modul 5: Best Practices
    ├── practice_list_page.dart        # Tab daftar seluruh modul praktik
    └── about_page.dart                # Tab informasi dan profil aplikasi
```

---

## 🚀 Cara Menjalankan Aplikasi

1. **Clone repository ini**:
   ```bash
   git clone <URL_REPOSITORY_ANDA>
   cd tugas7
   ```

2. **Ambil dependencies**:
   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi**:
   - Di Browser (Chrome):
     ```bash
     flutter run -d chrome
     ```
   - Di Android Device / Emulator:
     ```bash
     flutter run
     ```
   - Di Windows Desktop:
     ```bash
     flutter run -d windows
     ```

---
Dibuat untuk keperluan tugas & media pembelajaran State Management Dasar Flutter.
