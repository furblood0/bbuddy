import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In tr, this message translates to:
  /// **'BBuddy'**
  String get appTitle;

  /// No description provided for @cancel.
  ///
  /// In tr, this message translates to:
  /// **'İptal'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In tr, this message translates to:
  /// **'Sil'**
  String get delete;

  /// No description provided for @update.
  ///
  /// In tr, this message translates to:
  /// **'Güncelle'**
  String get update;

  /// No description provided for @skip.
  ///
  /// In tr, this message translates to:
  /// **'Atla'**
  String get skip;

  /// No description provided for @homeSettings.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get homeSettings;

  /// No description provided for @homeExpenses.
  ///
  /// In tr, this message translates to:
  /// **'Harcamalar'**
  String get homeExpenses;

  /// No description provided for @homeExpenseCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} kayıt'**
  String homeExpenseCount(int count);

  /// No description provided for @homeAddExpense.
  ///
  /// In tr, this message translates to:
  /// **'Harcama Ekle'**
  String get homeAddExpense;

  /// No description provided for @homeRemainingBudget.
  ///
  /// In tr, this message translates to:
  /// **'Kalan Bütçe'**
  String get homeRemainingBudget;

  /// No description provided for @homeBudgetExceeded.
  ///
  /// In tr, this message translates to:
  /// **'⚠ Bütçe Aşıldı'**
  String get homeBudgetExceeded;

  /// No description provided for @homeThisMonth.
  ///
  /// In tr, this message translates to:
  /// **'Bu Ay'**
  String get homeThisMonth;

  /// No description provided for @homeBudgetUsedPercent.
  ///
  /// In tr, this message translates to:
  /// **'%{percent} kullanıldı'**
  String homeBudgetUsedPercent(String percent);

  /// No description provided for @homeNoExpensesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz harcama eklenmedi'**
  String get homeNoExpensesTitle;

  /// No description provided for @homeNoExpensesSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Aşağıdaki butona basarak ilk harcamanı ekle'**
  String get homeNoExpensesSubtitle;

  /// No description provided for @homeSwipeToDelete.
  ///
  /// In tr, this message translates to:
  /// **'Sil'**
  String get homeSwipeToDelete;

  /// No description provided for @homeExpenseDeleted.
  ///
  /// In tr, this message translates to:
  /// **'Harcama silindi'**
  String get homeExpenseDeleted;

  /// No description provided for @homeUndo.
  ///
  /// In tr, this message translates to:
  /// **'Geri Al'**
  String get homeUndo;

  /// No description provided for @statsTitle.
  ///
  /// In tr, this message translates to:
  /// **'İstatistikler'**
  String get statsTitle;

  /// No description provided for @statsNoDataTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henüz gösterilecek veri yok'**
  String get statsNoDataTitle;

  /// No description provided for @statsNoDataSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Harcama ekledikçe grafikler burada görünür'**
  String get statsNoDataSubtitle;

  /// No description provided for @statsTotalExpenses.
  ///
  /// In tr, this message translates to:
  /// **'Toplam Harcama'**
  String get statsTotalExpenses;

  /// No description provided for @statsCategoryCount.
  ///
  /// In tr, this message translates to:
  /// **'Kategori Sayısı'**
  String get statsCategoryCount;

  /// No description provided for @statsBudgetUsage.
  ///
  /// In tr, this message translates to:
  /// **'Bütçe Kullanımı'**
  String get statsBudgetUsage;

  /// No description provided for @statsCategoryDistribution.
  ///
  /// In tr, this message translates to:
  /// **'Kategori Dağılımı'**
  String get statsCategoryDistribution;

  /// No description provided for @statsCategoryDetail.
  ///
  /// In tr, this message translates to:
  /// **'Kategori Detayı'**
  String get statsCategoryDetail;

  /// No description provided for @statsTotal.
  ///
  /// In tr, this message translates to:
  /// **'Toplam'**
  String get statsTotal;

  /// No description provided for @settingsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settingsTitle;

  /// No description provided for @settingsBudget.
  ///
  /// In tr, this message translates to:
  /// **'Bütçe'**
  String get settingsBudget;

  /// No description provided for @settingsMonthlyBudgetLimit.
  ///
  /// In tr, this message translates to:
  /// **'Aylık Bütçe Limiti'**
  String get settingsMonthlyBudgetLimit;

  /// No description provided for @settingsMonthlyBudgetDesc.
  ///
  /// In tr, this message translates to:
  /// **'Bu ay için maksimum harcama tutarı'**
  String get settingsMonthlyBudgetDesc;

  /// No description provided for @settingsLimitLabel.
  ///
  /// In tr, this message translates to:
  /// **'Limit'**
  String get settingsLimitLabel;

  /// No description provided for @settingsLimitHint.
  ///
  /// In tr, this message translates to:
  /// **'ör. 5000'**
  String get settingsLimitHint;

  /// No description provided for @settingsBudgetSaved.
  ///
  /// In tr, this message translates to:
  /// **'Bütçe limiti kaydedildi'**
  String get settingsBudgetSaved;

  /// No description provided for @settingsEnterLimit.
  ///
  /// In tr, this message translates to:
  /// **'Lütfen bir limit girin'**
  String get settingsEnterLimit;

  /// No description provided for @settingsEnterValidAmount.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir tutar girin'**
  String get settingsEnterValidAmount;

  /// No description provided for @settingsAppearance.
  ///
  /// In tr, this message translates to:
  /// **'Görünüm'**
  String get settingsAppearance;

  /// No description provided for @settingsCurrency.
  ///
  /// In tr, this message translates to:
  /// **'Para Birimi'**
  String get settingsCurrency;

  /// No description provided for @settingsSelectCurrency.
  ///
  /// In tr, this message translates to:
  /// **'Para Birimi Seç'**
  String get settingsSelectCurrency;

  /// No description provided for @settingsCurrencyUpdated.
  ///
  /// In tr, this message translates to:
  /// **'Para birimi güncellendi'**
  String get settingsCurrencyUpdated;

  /// No description provided for @settingsTheme.
  ///
  /// In tr, this message translates to:
  /// **'Tema'**
  String get settingsTheme;

  /// No description provided for @settingsSelectTheme.
  ///
  /// In tr, this message translates to:
  /// **'Tema Seç'**
  String get settingsSelectTheme;

  /// No description provided for @settingsThemeUpdated.
  ///
  /// In tr, this message translates to:
  /// **'Tema güncellendi'**
  String get settingsThemeUpdated;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In tr, this message translates to:
  /// **'Sistem'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeSystemDesc.
  ///
  /// In tr, this message translates to:
  /// **'Cihaz temasını kullan'**
  String get settingsThemeSystemDesc;

  /// No description provided for @settingsThemeLight.
  ///
  /// In tr, this message translates to:
  /// **'Açık'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeLightDesc.
  ///
  /// In tr, this message translates to:
  /// **'Her zaman açık tema'**
  String get settingsThemeLightDesc;

  /// No description provided for @settingsThemeDark.
  ///
  /// In tr, this message translates to:
  /// **'Koyu'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeDarkDesc.
  ///
  /// In tr, this message translates to:
  /// **'Her zaman koyu tema'**
  String get settingsThemeDarkDesc;

  /// No description provided for @settingsLanguage.
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get settingsLanguage;

  /// No description provided for @settingsSelectLanguage.
  ///
  /// In tr, this message translates to:
  /// **'Dil Seç'**
  String get settingsSelectLanguage;

  /// No description provided for @settingsLanguageUpdated.
  ///
  /// In tr, this message translates to:
  /// **'Dil güncellendi'**
  String get settingsLanguageUpdated;

  /// No description provided for @settingsAbout.
  ///
  /// In tr, this message translates to:
  /// **'Hakkında'**
  String get settingsAbout;

  /// No description provided for @settingsVersion.
  ///
  /// In tr, this message translates to:
  /// **'Versiyon'**
  String get settingsVersion;

  /// No description provided for @settingsPrivacy.
  ///
  /// In tr, this message translates to:
  /// **'Gizlilik'**
  String get settingsPrivacy;

  /// No description provided for @settingsPrivacyValue.
  ///
  /// In tr, this message translates to:
  /// **'Tüm veriler cihazında'**
  String get settingsPrivacyValue;

  /// No description provided for @settingsInternet.
  ///
  /// In tr, this message translates to:
  /// **'İnternet'**
  String get settingsInternet;

  /// No description provided for @settingsInternetValue.
  ///
  /// In tr, this message translates to:
  /// **'Kullanılmıyor'**
  String get settingsInternetValue;

  /// No description provided for @settingsClearAllData.
  ///
  /// In tr, this message translates to:
  /// **'Tüm Verileri Sil'**
  String get settingsClearAllData;

  /// No description provided for @settingsClearAllDataTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tüm Verileri Sil'**
  String get settingsClearAllDataTitle;

  /// No description provided for @settingsClearAllDataDesc.
  ///
  /// In tr, this message translates to:
  /// **'Tüm harcama kayıtların kalıcı olarak silinecek. Bu işlem geri alınamaz.'**
  String get settingsClearAllDataDesc;

  /// No description provided for @settingsAllDataDeleted.
  ///
  /// In tr, this message translates to:
  /// **'Tüm veriler silindi'**
  String get settingsAllDataDeleted;

  /// No description provided for @addExpenseTitle.
  ///
  /// In tr, this message translates to:
  /// **'Harcama Ekle'**
  String get addExpenseTitle;

  /// No description provided for @addExpenseTitleLabel.
  ///
  /// In tr, this message translates to:
  /// **'Harcama Başlığı'**
  String get addExpenseTitleLabel;

  /// No description provided for @addExpenseTitleHint.
  ///
  /// In tr, this message translates to:
  /// **'ör. Akşam yemeği'**
  String get addExpenseTitleHint;

  /// No description provided for @addExpenseEnterTitle.
  ///
  /// In tr, this message translates to:
  /// **'Lütfen bir başlık girin'**
  String get addExpenseEnterTitle;

  /// No description provided for @addExpenseAmount.
  ///
  /// In tr, this message translates to:
  /// **'Miktar'**
  String get addExpenseAmount;

  /// No description provided for @addExpenseAmountHint.
  ///
  /// In tr, this message translates to:
  /// **'ör. 150'**
  String get addExpenseAmountHint;

  /// No description provided for @addExpenseEnterAmount.
  ///
  /// In tr, this message translates to:
  /// **'Lütfen bir miktar girin'**
  String get addExpenseEnterAmount;

  /// No description provided for @addExpenseEnterValidAmount.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli bir miktar girin'**
  String get addExpenseEnterValidAmount;

  /// No description provided for @addExpenseCategory.
  ///
  /// In tr, this message translates to:
  /// **'Kategori'**
  String get addExpenseCategory;

  /// No description provided for @editExpenseTitle.
  ///
  /// In tr, this message translates to:
  /// **'Harcamayı Düzenle'**
  String get editExpenseTitle;

  /// No description provided for @editExpenseDeleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Harcamayı Sil'**
  String get editExpenseDeleteTitle;

  /// No description provided for @editExpenseDeleteConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Bu harcamayı silmek istediğine emin misin?'**
  String get editExpenseDeleteConfirm;

  /// No description provided for @onboardingSkip.
  ///
  /// In tr, this message translates to:
  /// **'Atla'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In tr, this message translates to:
  /// **'İleri'**
  String get onboardingNext;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In tr, this message translates to:
  /// **'Hadi Başlayalım'**
  String get onboardingGetStarted;

  /// No description provided for @onboarding1Title.
  ///
  /// In tr, this message translates to:
  /// **'BBuddy\'ye Hoş Geldin'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Desc.
  ///
  /// In tr, this message translates to:
  /// **'Harcamalarını kolayca kaydet ve bütçeni takip et. Tamamen ücretsiz, tamamen gizli.'**
  String get onboarding1Desc;

  /// No description provided for @onboarding2Title.
  ///
  /// In tr, this message translates to:
  /// **'Bütçeni Belirle'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Desc.
  ///
  /// In tr, this message translates to:
  /// **'Aylık bütçe limitini kendin ayarla. Limitine yaklaştığında uygulama seni uyarır.'**
  String get onboarding2Desc;

  /// No description provided for @onboarding3Title.
  ///
  /// In tr, this message translates to:
  /// **'Harcamalarını Analiz Et'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Desc.
  ///
  /// In tr, this message translates to:
  /// **'Kategori bazlı grafiklerle paranın nereye gittiğini görsel olarak takip et.'**
  String get onboarding3Desc;

  /// No description provided for @navHome.
  ///
  /// In tr, this message translates to:
  /// **'Ana Sayfa'**
  String get navHome;

  /// No description provided for @navStats.
  ///
  /// In tr, this message translates to:
  /// **'İstatistikler'**
  String get navStats;

  /// No description provided for @categoryFood.
  ///
  /// In tr, this message translates to:
  /// **'Yemek'**
  String get categoryFood;

  /// No description provided for @categoryTransport.
  ///
  /// In tr, this message translates to:
  /// **'Ulaşım'**
  String get categoryTransport;

  /// No description provided for @categoryEntertainment.
  ///
  /// In tr, this message translates to:
  /// **'Eğlence'**
  String get categoryEntertainment;

  /// No description provided for @categoryGrocery.
  ///
  /// In tr, this message translates to:
  /// **'Market'**
  String get categoryGrocery;

  /// No description provided for @categoryBills.
  ///
  /// In tr, this message translates to:
  /// **'Fatura'**
  String get categoryBills;

  /// No description provided for @categoryOther.
  ///
  /// In tr, this message translates to:
  /// **'Diğer'**
  String get categoryOther;

  /// No description provided for @languageTurkish.
  ///
  /// In tr, this message translates to:
  /// **'Türkçe'**
  String get languageTurkish;

  /// No description provided for @languageTurkishRegion.
  ///
  /// In tr, this message translates to:
  /// **'Türkiye'**
  String get languageTurkishRegion;

  /// No description provided for @languageEnglish.
  ///
  /// In tr, this message translates to:
  /// **'İngilizce'**
  String get languageEnglish;

  /// No description provided for @languageEnglishRegion.
  ///
  /// In tr, this message translates to:
  /// **'United States'**
  String get languageEnglishRegion;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
