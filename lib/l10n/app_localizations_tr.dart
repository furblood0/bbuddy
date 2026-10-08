// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get cancel => 'İptal';

  @override
  String get save => 'Kaydet';

  @override
  String get delete => 'Sil';

  @override
  String get update => 'Güncelle';

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
  String get homeNoExpensesTitle => 'Henüz kayıt yok';

  @override
  String get homeNoExpensesSubtitle =>
      'Aşağıdaki butona basarak ilk gelirini veya harcamanı ekle';

  @override
  String get homeSwipeToDelete => 'Sil';

  @override
  String get homeExpenseDeleted => 'Harcama silindi';

  @override
  String get homeUndo => 'Geri Al';

  @override
  String get homeRecords => 'Kayıtlar';

  @override
  String get homeAddRecord => 'Ekle';

  @override
  String get homeIncome => 'Gelir';

  @override
  String get homeSpent => 'Gider';

  @override
  String get homeNet => 'Net';

  @override
  String get homeRecordDeleted => 'Kayıt silindi';

  @override
  String get statsTitle => 'İstatistikler';

  @override
  String get statsNoDataTitle => 'Henüz gösterilecek veri yok';

  @override
  String get statsNoDataSubtitle =>
      'Gelir veya harcama ekledikçe grafikler burada görünür';

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
  String get statsSelectMonth => 'Ay Seç';

  @override
  String get statsPreviousMonth => 'Önceki ay';

  @override
  String get statsNextMonth => 'Sonraki ay';

  @override
  String get statsNoExpenses => 'Bu ay harcama yok';

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
      'Tüm gelir ve harcama kayıtların kalıcı olarak silinecek. Bütçe limiti kalır. Bu işlem geri alınamaz.';

  @override
  String get settingsAllDataDeleted => 'Tüm veriler silindi';

  @override
  String get settingsData => 'Veri';

  @override
  String get settingsExport => 'Yedeği dışa aktar';

  @override
  String get settingsExportDesc =>
      'Gelir, harcama ve bütçe limitini JSON dosyası olarak paylaş';

  @override
  String get settingsExportFailed => 'Yedek oluşturulamadı';

  @override
  String get settingsImport => 'Yedeği içe aktar';

  @override
  String get settingsImportDesc =>
      'Daha önce dışa aktardığın JSON dosyasını yükle';

  @override
  String get settingsImportConfirmTitle => 'Yedek içe aktarılsın mı?';

  @override
  String settingsImportConfirmBody(int count, String limit) {
    return '$count kayıt yüklenecek ve bütçe limiti $limit olacak. Mevcut kayıtların değiştirilir.';
  }

  @override
  String get settingsImportDone => 'Yedek içe aktarıldı';

  @override
  String get settingsImportInvalid =>
      'Bu dosya geçerli bir BBuddy yedeği değil';

  @override
  String get settingsImportVersion =>
      'Bu yedek daha yeni bir sürümden. Uygulamayı güncelle.';

  @override
  String get settingsImportEmpty => 'Dosya boş';

  @override
  String get addExpenseTitle => 'Harcama Ekle';

  @override
  String get addExpenseTitleLabel => 'Not (isteğe bağlı)';

  @override
  String get addExpenseTitleHint => 'ör. Akşam yemeği arkadaşlarla';

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
  String get addExpenseDate => 'Tarih';

  @override
  String get kindExpense => 'Gider';

  @override
  String get kindIncome => 'Gelir';

  @override
  String get addIncomeTitle => 'Gelir Ekle';

  @override
  String get addIncomeTitleHint => 'ör. Ekim harçlığı';

  @override
  String get editExpenseTitle => 'Harcamayı Düzenle';

  @override
  String get editExpenseDeleteTitle => 'Harcamayı Sil';

  @override
  String get editExpenseDeleteConfirm =>
      'Bu harcamayı silmek istediğine emin misin?';

  @override
  String get editIncomeTitle => 'Geliri Düzenle';

  @override
  String get editIncomeDeleteTitle => 'Geliri Sil';

  @override
  String get editIncomeDeleteConfirm =>
      'Bu geliri silmek istediğine emin misin?';

  @override
  String get onboardingSkip => 'Atla';

  @override
  String get onboardingNext => 'İleri';

  @override
  String get onboardingGetStarted => 'Hadi Başlayalım';

  @override
  String get onboardingSetBudget => 'Bütçemi belirle';

  @override
  String get onboarding1Title => 'BBuddy\'ye Hoş Geldin';

  @override
  String get onboarding1Desc =>
      'Harcamalarını kolayca kaydet ve bütçeni takip et. Tamamen ücretsiz, tamamen gizli.';

  @override
  String get onboarding2Title => 'Bütçeni Belirle';

  @override
  String get onboarding2Desc =>
      'Aylık harcama limitini kendin belirle. Ana ekranda kalan tutarı ve ne kadarını kullandığını gör.';

  @override
  String get onboarding3Title => 'Harcamalarını Analiz Et';

  @override
  String get onboarding3Desc =>
      'Kategori bazlı grafiklerle paranın nereye gittiğini görsel olarak takip et.';

  @override
  String get budgetSetupTitle => 'Aylık bütçen ne kadar?';

  @override
  String get budgetSetupSubtitle =>
      'Bu, ay içinde harcamayı planladığın tutar. Gelirlerini ayrıca ekleyebilir, limiti daha sonra ayarlardan değiştirebilirsin.';

  @override
  String get budgetSetupContinue => 'Başla';

  @override
  String get navHome => 'Ana Sayfa';

  @override
  String get navStats => 'İstatistikler';

  @override
  String get categoryFood => 'Yemek';

  @override
  String get categoryGrocery => 'Market';

  @override
  String get categoryTransport => 'Ulaşım';

  @override
  String get categoryEducation => 'Eğitim';

  @override
  String get categoryHealth => 'Sağlık';

  @override
  String get categorySubscription => 'Abonelik';

  @override
  String get categoryHousing => 'Konaklama';

  @override
  String get categoryEntertainment => 'Eğlence';

  @override
  String get categoryBills => 'Fatura';

  @override
  String get categoryOther => 'Diğer';

  @override
  String get categoryAllowance => 'Harçlık';

  @override
  String get categoryScholarship => 'Burs';

  @override
  String get categoryJob => 'İş';

  @override
  String get categoryFamily => 'Aile';

  @override
  String get privacyTitle => 'Gizlilik Politikası';

  @override
  String get privacyIntro =>
      'BBuddy tamamen çevrimdışı çalışır. Girdiğin bilgiler cihazından çıkmaz.';

  @override
  String get privacyCollectTitle => 'Toplanan veriler';

  @override
  String get privacyCollectBody =>
      'BBuddy kişisel veri toplamaz. Harcamalar, gelirler, bütçe limiti ve tema ile dil tercihin yalnızca cihazında saklanır.';

  @override
  String get privacyInternetTitle => 'İnternet';

  @override
  String get privacyInternetBody =>
      'Uygulama internet izni istemez ve bir sunucuya bağlanmaz. Hesap, reklam ve analitik yoktur.';

  @override
  String get privacyBackupTitle => 'Yedek dosyası';

  @override
  String get privacyBackupBody =>
      'Yedeği dışa aktardığında cihazında bir JSON dosyası oluşur. Bu dosya yalnızca sen paylaşırsan başka bir uygulamaya gider.';

  @override
  String get privacyDeleteTitle => 'Verileri silmek';

  @override
  String get privacyDeleteBody =>
      'Ayarlar içinden tüm gelir ve harcama kayıtlarını silebilir veya uygulamayı kaldırabilirsin. Kaldırmak cihazda kalan veriyi de siler.';

  @override
  String get privacyContactTitle => 'İletişim';

  @override
  String privacyContactBody(String email) {
    return 'Soruların için: $email';
  }

  @override
  String get languageTurkish => 'Türkçe';

  @override
  String get languageTurkishRegion => 'Türkiye';

  @override
  String get languageEnglish => 'İngilizce';

  @override
  String get languageEnglishRegion => 'United States';
}
