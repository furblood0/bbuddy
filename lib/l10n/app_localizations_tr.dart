// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'BBuddy';

  @override
  String get cancel => 'İptal';

  @override
  String get save => 'Kaydet';

  @override
  String get delete => 'Sil';

  @override
  String get update => 'Güncelle';

  @override
  String get skip => 'Atla';

  @override
  String get homeSettings => 'Ayarlar';

  @override
  String get homeExpenses => 'Harcamalar';

  @override
  String homeExpenseCount(int count) {
    return '$count kayıt';
  }

  @override
  String get homeAddExpense => 'Harcama Ekle';

  @override
  String get homeRemainingBudget => 'Kalan Bütçe';

  @override
  String get homeBudgetExceeded => '⚠ Bütçe Aşıldı';

  @override
  String get homeThisMonth => 'Bu Ay';

  @override
  String homeBudgetUsedPercent(String percent) {
    return '%$percent kullanıldı';
  }

  @override
  String get homeNoExpensesTitle => 'Henüz harcama eklenmedi';

  @override
  String get homeNoExpensesSubtitle =>
      'Aşağıdaki butona basarak ilk harcamanı ekle';

  @override
  String get homeSwipeToDelete => 'Sil';

  @override
  String get homeExpenseDeleted => 'Harcama silindi';

  @override
  String get homeUndo => 'Geri Al';

  @override
  String get statsTitle => 'İstatistikler';

  @override
  String get statsNoDataTitle => 'Henüz gösterilecek veri yok';

  @override
  String get statsNoDataSubtitle =>
      'Harcama ekledikçe grafikler burada görünür';

  @override
  String get statsTotalExpenses => 'Toplam Harcama';

  @override
  String get statsCategoryCount => 'Kategori Sayısı';

  @override
  String get statsBudgetUsage => 'Bütçe Kullanımı';

  @override
  String get statsCategoryDistribution => 'Kategori Dağılımı';

  @override
  String get statsCategoryDetail => 'Kategori Detayı';

  @override
  String get statsTotal => 'Toplam';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsBudget => 'Bütçe';

  @override
  String get settingsMonthlyBudgetLimit => 'Aylık Bütçe Limiti';

  @override
  String get settingsMonthlyBudgetDesc => 'Bu ay için maksimum harcama tutarı';

  @override
  String get settingsLimitLabel => 'Limit';

  @override
  String get settingsLimitHint => 'ör. 5000';

  @override
  String get settingsBudgetSaved => 'Bütçe limiti kaydedildi';

  @override
  String get settingsEnterLimit => 'Lütfen bir limit girin';

  @override
  String get settingsEnterValidAmount => 'Geçerli bir tutar girin';

  @override
  String get settingsAppearance => 'Görünüm';

  @override
  String get settingsCurrency => 'Para Birimi';

  @override
  String get settingsSelectCurrency => 'Para Birimi Seç';

  @override
  String get settingsCurrencyUpdated => 'Para birimi güncellendi';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsSelectTheme => 'Tema Seç';

  @override
  String get settingsThemeUpdated => 'Tema güncellendi';

  @override
  String get settingsThemeSystem => 'Sistem';

  @override
  String get settingsThemeSystemDesc => 'Cihaz temasını kullan';

  @override
  String get settingsThemeLight => 'Açık';

  @override
  String get settingsThemeLightDesc => 'Her zaman açık tema';

  @override
  String get settingsThemeDark => 'Koyu';

  @override
  String get settingsThemeDarkDesc => 'Her zaman koyu tema';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsSelectLanguage => 'Dil Seç';

  @override
  String get settingsLanguageUpdated => 'Dil güncellendi';

  @override
  String get settingsAbout => 'Hakkında';

  @override
  String get settingsVersion => 'Versiyon';

  @override
  String get settingsPrivacy => 'Gizlilik';

  @override
  String get settingsPrivacyValue => 'Tüm veriler cihazında';

  @override
  String get settingsInternet => 'İnternet';

  @override
  String get settingsInternetValue => 'Kullanılmıyor';

  @override
  String get settingsClearAllData => 'Tüm Verileri Sil';

  @override
  String get settingsClearAllDataTitle => 'Tüm Verileri Sil';

  @override
  String get settingsClearAllDataDesc =>
      'Tüm harcama kayıtların kalıcı olarak silinecek. Bu işlem geri alınamaz.';

  @override
  String get settingsAllDataDeleted => 'Tüm veriler silindi';

  @override
  String get addExpenseTitle => 'Harcama Ekle';

  @override
  String get addExpenseTitleLabel => 'Harcama Başlığı';

  @override
  String get addExpenseTitleHint => 'ör. Akşam yemeği';

  @override
  String get addExpenseEnterTitle => 'Lütfen bir başlık girin';

  @override
  String get addExpenseAmount => 'Miktar';

  @override
  String get addExpenseAmountHint => 'ör. 150';

  @override
  String get addExpenseEnterAmount => 'Lütfen bir miktar girin';

  @override
  String get addExpenseEnterValidAmount => 'Geçerli bir miktar girin';

  @override
  String get addExpenseCategory => 'Kategori';

  @override
  String get editExpenseTitle => 'Harcamayı Düzenle';

  @override
  String get editExpenseDeleteTitle => 'Harcamayı Sil';

  @override
  String get editExpenseDeleteConfirm =>
      'Bu harcamayı silmek istediğine emin misin?';

  @override
  String get onboardingSkip => 'Atla';

  @override
  String get onboardingNext => 'İleri';

  @override
  String get onboardingGetStarted => 'Hadi Başlayalım';

  @override
  String get onboarding1Title => 'BBuddy\'ye Hoş Geldin';

  @override
  String get onboarding1Desc =>
      'Harcamalarını kolayca kaydet ve bütçeni takip et. Tamamen ücretsiz, tamamen gizli.';

  @override
  String get onboarding2Title => 'Bütçeni Belirle';

  @override
  String get onboarding2Desc =>
      'Aylık bütçe limitini kendin ayarla. Limitine yaklaştığında uygulama seni uyarır.';

  @override
  String get onboarding3Title => 'Harcamalarını Analiz Et';

  @override
  String get onboarding3Desc =>
      'Kategori bazlı grafiklerle paranın nereye gittiğini görsel olarak takip et.';

  @override
  String get navHome => 'Ana Sayfa';

  @override
  String get navStats => 'İstatistikler';

  @override
  String get categoryFood => 'Yemek';

  @override
  String get categoryTransport => 'Ulaşım';

  @override
  String get categoryEntertainment => 'Eğlence';

  @override
  String get categoryGrocery => 'Market';

  @override
  String get categoryBills => 'Fatura';

  @override
  String get categoryOther => 'Diğer';

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageTurkishRegion => 'Türkiye';

  @override
  String get languageEnglish => 'İngilizce';

  @override
  String get languageEnglishRegion => 'United States';
}
