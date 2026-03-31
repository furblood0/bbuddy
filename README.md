# 💰 BBuddy — Budget Tracker / Bütçe Takip Uygulaması

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Platform-Android-3DDC84?style=flat&logo=android&logoColor=white" />
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=flat" />
  <img src="https://img.shields.io/badge/Status-In%20Development-orange?style=flat" />
</p>

> A privacy-focused, offline-first budget tracking app for university students.  
> Üniversite öğrencileri için gizlilik odaklı, çevrimdışı çalışan bütçe takip uygulaması.

---

## 🇬🇧 English

### About
BBuddy helps university students track their daily expenses, set monthly budget limits, and visualize spending habits — all without requiring an internet connection. Your data never leaves your device.

### ✨ Features
- ➕ **Add / Edit / Delete** expenses with title, amount, category and date
- 💳 **Budget limit** — set a monthly limit, stored permanently on device
- 📊 **Statistics screen** — interactive pie chart with category breakdown
- 🎨 **Modern UI** — Material 3 design with full dark mode support
- 🔒 **100% offline** — all data stored locally with Hive (no internet permission)
- 🚀 **Onboarding** — smooth 3-slide intro shown only on first launch

### 🗂️ Categories
| Category | Turkish |
|----------|---------|
| 🍽️ Food | Yemek |
| 🚌 Transport | Ulaşım |
| 🎬 Entertainment | Eğlence |
| 🛒 Groceries | Market |
| 📄 Bills | Fatura |
| 📦 Other | Diğer |

### 🛠️ Tech Stack
| Tool | Purpose |
|------|---------|
| [Flutter](https://flutter.dev) | UI Framework |
| [Hive](https://pub.dev/packages/hive_flutter) | Local NoSQL database |
| [Provider](https://pub.dev/packages/provider) | State management |
| [fl_chart](https://pub.dev/packages/fl_chart) | Charts & graphs |
| [uuid](https://pub.dev/packages/uuid) | Unique expense IDs |

### 🏗️ Project Structure
```
lib/
├── core/
│   └── category_helper.dart      # Category icons & colors
├── models/
│   └── expense.dart              # Hive data model
├── providers/
│   └── expense_provider.dart     # State management
├── services/
│   └── database_service.dart     # Hive read/write operations
└── views/
    ├── main_screen.dart          # Bottom navigation wrapper
    ├── home/                     # Home screen + add/edit sheets
    ├── stats/                    # Statistics & pie chart
    ├── settings/                 # Budget limit settings
    └── onboarding/               # First-launch onboarding
```

### 🚀 Getting Started
**Prerequisites:** Flutter SDK 3.x, Android SDK

```bash
# Clone the repository
git clone https://github.com/furblood0/bbuddy.git
cd bbuddy

# Install dependencies
flutter pub get

# Run on connected device / emulator
flutter run
```

### 📦 Build APK
```bash
flutter build apk --release
```

---

## 🇹🇷 Türkçe

### Hakkında
BBuddy, üniversite öğrencilerinin günlük harcamalarını takip etmelerine, aylık bütçe limiti belirlemelerine ve harcama alışkanlıklarını görselleştirmelerine yardımcı olan bir mobil uygulamadır. İnternet bağlantısı gerektirmez; tüm veriler yalnızca cihazında saklanır.

### ✨ Özellikler
- ➕ **Harcama ekleme / düzenleme / silme** — başlık, tutar, kategori ve tarih ile
- 💳 **Bütçe limiti** — aylık limit belirle, uygulama kapanınca sıfırlanmaz
- 📊 **İstatistik ekranı** — kategori bazlı interaktif pasta grafiği
- 🎨 **Modern tasarım** — Material 3, sistem dark mode desteği
- 🔒 **Tamamen çevrimdışı** — internet izni yok, veriler Hive ile cihazda saklanır
- 🚀 **Onboarding** — ilk açılışta gösterilen 3 slaytlık tanıtım ekranı

### 🚀 Kurulum
**Gereksinimler:** Flutter SDK 3.x, Android SDK

```bash
# Repoyu klonla
git clone https://github.com/furblood0/bbuddy.git
cd bbuddy

# Paketleri yükle
flutter pub get

# Emülatör veya cihazda çalıştır
flutter run
```

### 📦 APK Oluşturma
```bash
flutter build apk --release
```

---

## 📄 License / Lisans
This project is licensed under the MIT License.  
Bu proje MIT Lisansı ile lisanslanmıştır.
