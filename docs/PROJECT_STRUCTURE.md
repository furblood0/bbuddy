# BBuddy — Proje Yapısı ve Dosya Rehberi

Bu belge, `bbuddy` Flutter projesindeki klasör ve dosyaların ne işe yaradığını açıklar. Gereksiz dosyaları temizlerken referans olarak kullanılabilir.

**Uygulama özeti:** Üniversite öğrencileri için çevrimdışı bütçe takip uygulaması. Harcamalar Hive ile cihazda saklanır; Provider ile durum yönetimi yapılır. Yalnızca **Android** platformu yapılandırılmış (iOS klasörü yok).

---

## Hızlı özet: Ne silinebilir?

| Konum | Silinebilir mi? | Açıklama |
|-------|-----------------|----------|
| `.dart_tool/` | Evet (yeniden oluşur) | Derleme/cache; `flutter pub get` ile gelir |
| `build/` | Evet (yeniden oluşur) | APK/derleme çıktıları |
| `android/.gradle/` | Evet (yeniden oluşur) | Gradle önbelleği |
| `android/.kotlin/` | Evet (yeniden oluşur) | Kotlin derleme oturumları |
| `.idea/` | Evet (IDE ayarı) | Android Studio; `.gitignore`’da zaten |
| `*.iml` (`bbuddy.iml`, `android/bbuddy_android.iml`) | Evet | IntelliJ modül dosyaları; `.gitignore`’da |
| `android/local.properties` | Evet (yeniden oluşur) | Yerel SDK yolu; commit edilmemeli |
| `test/` (boş klasör) | İsteğe bağlı | `test/backup_codec_test.dart` yedek formatını doğrular |
| `lib/l10n/app_localizations*.dart` | **Hayır** | Flutter `generate: true` ile üretilir; kaynak `.arb` dosyaları |
| `lib/models/expense.g.dart` | **Hayır** | `build_runner` ile üretilir; `expense.dart` için gerekli |
| `android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java` | **Hayır** | Flutter plugin kaydı; otomatik üretilir |

Temizlik komutu (güvenli):

```bash
flutter clean
```

Ardından tekrar derlemek için: `flutter pub get` ve `dart run build_runner build` (Hive adapter değişirse).

---

## Kök dizin (`/`)

| Dosya / Klasör | Gerekli mi? | Ne işe yarar? |
|----------------|-------------|---------------|
| `lib/` | **Evet** | Tüm uygulama kaynak kodu |
| `android/` | **Evet** | Android derleme ve manifest |
| `docs/` | İsteğe bağlı | Dokümantasyon (`privacy-policy.html`, bu dosya) |
| `test/` | Evet | `backup_codec_test.dart` — yedek formatı ve eski Hive kaydı |
| `pubspec.yaml` | **Evet** | Bağımlılıklar, sürüm, Flutter ayarları |
| `pubspec.lock` | **Evet** | Kilitli paket sürümleri |
| `l10n.yaml` | **Evet** | Çoklu dil üretim yapılandırması |
| `analysis_options.yaml` | **Evet** | Dart linter / analyzer kuralları |
| `README.md` | İsteğe bağlı | Proje tanıtımı (İngilizce + Türkçe) |
| `LICENSE` | İsteğe bağlı | MIT lisans metni |
| `.gitignore` | **Evet** | Git’e girmemesi gereken dosyalar |
| `.gitattributes` | İsteğe bağlı | Git satır sonu / binary ayarları |
| `.metadata` | **Evet** | Flutter SDK sürümü ve proje tipi (araçlar için) |
| `.flutter-plugins-dependencies` | Otomatik | Plugin bağımlılık listesi (üretilir) |
| `bbuddy.iml` | Hayır | Android Studio modül dosyası — silinebilir |
| `.dart_tool/` | Otomatik | Derleme önbelleği — `flutter clean` ile silinir |
| `build/` | Otomatik | Derleme çıktısı — `flutter clean` ile silinir |
| `.idea/` | Hayır | Android Studio workspace — silinebilir |
| `.git/` | **Evet** | Versiyon kontrolü |

### `pubspec.yaml` bağımlılıkları

| Paket | Rol |
|-------|-----|
| `provider` | `ExpenseProvider`, `SettingsProvider` state yönetimi |
| `hive` / `hive_flutter` | Yerel NoSQL veritabanı |
| `fl_chart` | İstatistik ekranında pasta grafik |
| `uuid` | Her harcamaya benzersiz `id` |
| `intl` | Tarih formatlama (`DateFormat`) |
| `flutter_localizations` | Material yerelleştirme delegeleri |
| `build_runner` + `hive_generator` (dev) | `expense.g.dart` üretimi |

---

## `lib/` — Uygulama kaynak kodu

### `lib/main.dart`

Uygulama giriş noktası:

1. Hive başlatılır, `ExpenseAdapter` kaydedilir
2. Onboarding görüldü mü kontrol edilir (`DatabaseService`)
3. `SettingsProvider` ayarları yükler (tema, dil)
4. `MultiProvider` ile `ExpenseProvider` + `SettingsProvider` sağlanır
5. `MaterialApp`: tema, `tr`/`en` locale, onboarding veya `MainScreen`

---

### `lib/core/` — Paylaşılan yardımcılar ve tasarım

| Dosya | Ne işe yarar? |
|-------|---------------|
| `app_theme.dart` | Material 3 açık/koyu tema; marka renkleri (teal tonları), `ThemeData` bileşenleri |
| `app_styles.dart` | Ortak border radius, padding, kart dekorasyonları (`surfaceCard`, `budgetCard`) |
| `amount_formatter.dart` | TL tutar formatı: `1.234,56 ₺` (binlik ayırıcı nokta, ondalık virgül) |
| `category_helper.dart` | 10 sabit kategori anahtarı (`food`, `transport`, …), ikon/renk, `normalize`, yerelleştirilmiş başlık üretimi |
| `app_info.dart` | Uygulama sürümü (`pubspec.yaml` ile senkron tutulur) |

**Not:** README’deki kategori listesi (6 kategori) güncel değil; kodda 10 kategori var.

---

### `lib/models/` — Veri modeli

| Dosya | Ne işe yarar? |
|-------|---------------|
| `expense.dart` | Hive modeli: `id`, `title`, `amount`, `date`, `category`. `@HiveType(typeId: 0)` |
| `expense.g.dart` | **Otomatik üretilir** — `ExpenseAdapter` (okuma/yazma). Elle düzenlenmemeli. Yeniden üretim: `dart run build_runner build --delete-conflicting-outputs` |

---

### `lib/providers/` — Durum yönetimi (Provider)

| Dosya | Ne işe yarar? |
|-------|---------------|
| `expense_provider.dart` | Harcama listesi, aylık filtre, toplam harcama, kalan bütçe, kategori toplamları, ay listesi; CRUD + bütçe limiti + tüm harcamaları silme |
| `settings_provider.dart` | `ThemeMode` (sistem/açık/koyu) ve `Locale` (`tr`/`en`); Hive’a kaydeder |

---

### `lib/services/` — Veri katmanı

| Dosya | Ne işe yarar? |
|-------|---------------|
| `database_service.dart` | Hive kutuları: `expenses_box` (harcamalar), `settings_box` (bütçe, onboarding, tema, dil) |

**Hive anahtarları:**

- `budget_limit` — varsayılan 5000
- `onboarding_seen` — ilk açılış bayrağı
- `theme_mode` — `ThemeMode` index
- `language_code` — `tr` veya `en`

---

### `lib/l10n/` — Çoklu dil (yerelleştirme)

| Dosya | Ne işe yarar? |
|-------|---------------|
| `app_tr.arb` | Türkçe metinler (şablon dosya — `l10n.yaml`’da `template-arb-file`) |
| `app_en.arb` | İngilizce metinler |
| `app_localizations.dart` | **Üretilir** — `AppLocalizations` sınıfı ve delegate |
| `app_localizations_tr.dart` | **Üretilir** — Türkçe implementasyon |
| `app_localizations_en.dart` | **Üretilir** — İngilizce implementasyon |

Kaynak: yalnızca `.arb` dosyalarını düzenle. `flutter gen-l10n` veya `flutter pub get` ile `.dart` dosyaları yenilenir.

Kök `l10n.yaml`:

```yaml
arb-dir: lib/l10n
template-arb-file: app_tr.arb
output-localization-file: app_localizations.dart
```

---

### `lib/views/` — Arayüz ekranları

#### `main_screen.dart`

Alt navigasyon (Ana Sayfa / İstatistik), `PageView` ile iki sekme. Ayarlar burada değil; ana sayfadan açılır.

#### `home/`

| Dosya | Ne işe yarar? |
|-------|---------------|
| `home_screen.dart` | Bütçe kartı, bu ayın harcama listesi, ekleme FAB, düzenleme/silme, ayarlara geçiş |
| `widgets/add_expense_sheet.dart` | Alt sayfa: yeni harcama (başlık, tutar, kategori, tarih) |
| `widgets/edit_expense_sheet.dart` | Alt sayfa: mevcut harcamayı düzenleme / silme |
| `widgets/expense_date_field.dart` | Tarih seçici alan bileşeni (add/edit sheet’lerde ortak) |

#### `stats/`

| Dosya | Ne işe yarar? |
|-------|---------------|
| `stats_screen.dart` | Ay seçici, seçilen ay için istatistik; veri yoksa boş durum |

#### `settings/`

| Dosya | Ne işe yarar? |
|-------|---------------|
| `settings_screen.dart` | Aylık bütçe limiti, tema, dil, tüm harcamaları silme, gizlilik politikası linki vb. (~600 satır) |

#### `onboarding/`

| Dosya | Ne işe yarar? |
|-------|---------------|
| `onboarding_screen.dart` | İlk açılışta 3 slayt; bitince `onboarding_seen` kaydedilir ve `MainScreen`’e geçilir |

#### `shared/` — Tekrar kullanılan UI

| Dosya | Ne işe yarar? |
|-------|---------------|
| `screen_header.dart` | Ortak `AppBar` (ikon + başlık + opsiyonel aksiyonlar) |
| `empty_state.dart` | Liste/grafik boşken gösterilen illüstrasyon + metin |
| `monthly_stats_view.dart` | Pasta grafik (`fl_chart`), kategori dökümü, bütçe özeti (stats ekranında kullanılır) |

---

## `android/` — Android platformu

| Dosya / Klasör | Ne işe yarar? |
|----------------|---------------|
| `settings.gradle.kts` | Gradle proje ayarları |
| `build.gradle.kts` | Kök Android build script |
| `gradle.properties` | Gradle JVM / Android özellikleri |
| `gradle/wrapper/` | Gradle wrapper (`gradlew`, `gradle-wrapper.jar`) — **gerekli** |
| `gradlew` / `gradlew.bat` | Gradle komut satırı betikleri |
| `local.properties` | Yerel Android SDK yolu — **commit etme**, silinebilir |
| `.gradle/` | Gradle cache — silinebilir |
| `.kotlin/` | Kotlin derleme oturumları — silinebilir |
| `bbuddy_android.iml` | IDE dosyası — silinebilir |

### `android/app/`

| Dosya | Ne işe yarar? |
|-------|---------------|
| `build.gradle.kts` | `applicationId`: `com.furblood.bbuddy`. Release imzası `android/key.properties` varsa upload keystore, yoksa debug |
| `src/main/AndroidManifest.xml` | Uygulama adı, launcher activity, **internet izni yok** (offline) |
| `src/main/kotlin/.../MainActivity.kt` | Flutter embedding giriş activity’si (standart) |
| `src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java` | Flutter plugin kaydı — otomatik |
| `src/main/res/values/styles.xml` | Açık tema (splash / normal) |
| `src/main/res/values-night/styles.xml` | Koyu tema stilleri |
| `src/main/res/drawable/launch_background.xml` | Açılış ekranı arka planı |
| `src/main/res/drawable-v21/launch_background.xml` | API 21+ splash |
| `src/main/res/mipmap-*/ic_launcher.png` | Uygulama ikonu (varsayılan Flutter ikonu) |
| `src/debug/AndroidManifest.xml` | Debug build manifest ekleri |
| `src/profile/AndroidManifest.xml` | Profile build manifest ekleri |

**Yayın öncesi:**

- `applicationId`: `com.furblood.bbuddy` (ilk Play yüklemesinden sonra değiştirilemez)
- Release imzası için `android/key.properties` ve `upload-keystore.jks` gerekir; ikisi de git’e girmez
- Gizlilik sayfasını GitHub Pages ile yayınla: `docs/privacy-policy.html`

---

## `docs/`

| Dosya | Ne işe yarar? |
|-------|---------------|
| `privacy-policy.html` | TR/EN gizlilik politikası (GitHub Pages veya mağaza linki için) |
| `PROJECT_STRUCTURE.md` | Bu rehber |

---

## `test/`

`test/backup_codec_test.dart` yedek JSON’unun gidiş-dönüşünü, hatalı dosyayı ve gelir alanı eklenmeden önce kaydedilmiş Hive kayıtlarının okunmasını doğrular.

```bash
flutter test
```

---

## Veri akışı (basit şema)

```
UI (views/)
    ↓ read/watch, add/update/delete
Provider (expense_provider, settings_provider)
    ↓
DatabaseService
    ↓
Hive (expenses_box, settings_box) — cihazda kalıcı
```

---

## README ile gerçek yapı farkları

`README.md` içindeki yapı özeti eksik/güncel değil:

| README’de yok | Projede var |
|---------------|-------------|
| `core/app_theme.dart`, `app_styles.dart`, `amount_formatter.dart` | Var |
| `settings_provider.dart` | Var |
| `l10n/` klasörü | Var (TR + EN) |
| `views/shared/` | Var |
| `views/home/widgets/` | Var |
| 6 kategori | Kodda **10** kategori |

Temizlik sonrası README’yi güncellemek faydalı olur.

---

## Önerilen temizlik sırası

1. **Git’e girmemesi gerekenleri kontrol et** — `git status` ile `.dart_tool`, `build`, `android/.gradle` untracked ise normal; commit etme.
2. **`flutter clean`** — `build/`, `.dart_tool` büyük önbelleği temizler.
3. **IDE dosyaları** — `.idea/`, `*.iml` silinebilir (Android Studio yeniden oluşturur).
4. **`android/local.properties`** — silinirse Android Studio/SDK yolu yeniden yazılır.
5. **Testler** — `flutter test` yedek formatını doğrular.
6. **Üretilen dosyaları elle silme** — `expense.g.dart` ve `app_localizations*.dart` silinirse `pub get` / `build_runner` ile geri üret.

---

## Dosya sayısı özeti (kaynak kod, üretilen hariç)

| Alan | Yaklaşık dosya sayısı |
|------|------------------------|
| `lib/` Dart kaynak | ~25 (üretilenler dahil ~30) |
| `android/` kaynak | ~15 (wrapper jar hariç) |
| Kök yapılandırma | ~8 |
| `docs/` | 2 |

Proje küçük ve odaklı; asıl “şişkinlik” `.dart_tool/`, `build/`, `android/.gradle/` gibi **derleme çıktılarından** gelir — bunlar `.gitignore`’da ve repoya eklenmemeli.

---

*Son güncelleme: proje incelemesine göre oluşturuldu (Flutter 3.x, BBuddy v1.0.0+1).*
