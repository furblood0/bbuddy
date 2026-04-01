// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'BBuddy';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get update => 'Update';

  @override
  String get skip => 'Skip';

  @override
  String get homeSettings => 'Settings';

  @override
  String get homeExpenses => 'Expenses';

  @override
  String homeExpenseCount(int count) {
    return '$count records';
  }

  @override
  String get homeAddExpense => 'Add Expense';

  @override
  String get homeRemainingBudget => 'Remaining Budget';

  @override
  String get homeBudgetExceeded => '⚠ Over Budget';

  @override
  String get homeThisMonth => 'This Month';

  @override
  String homeBudgetUsedPercent(String percent) {
    return '$percent% used';
  }

  @override
  String get homeNoExpensesTitle => 'No expenses yet';

  @override
  String get homeNoExpensesSubtitle =>
      'Tap the button below to add your first expense';

  @override
  String get homeSwipeToDelete => 'Delete';

  @override
  String get statsTitle => 'Statistics';

  @override
  String get statsNoDataTitle => 'No data to show yet';

  @override
  String get statsNoDataSubtitle =>
      'Charts will appear here as you add expenses';

  @override
  String get statsTotalExpenses => 'Total Expenses';

  @override
  String get statsCategoryCount => 'Categories';

  @override
  String get statsBudgetUsage => 'Budget Usage';

  @override
  String get statsCategoryDistribution => 'Category Distribution';

  @override
  String get statsCategoryDetail => 'Category Detail';

  @override
  String get statsTotal => 'Total';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsBudget => 'Budget';

  @override
  String get settingsMonthlyBudgetLimit => 'Monthly Budget Limit';

  @override
  String get settingsMonthlyBudgetDesc =>
      'Maximum spending amount for this month';

  @override
  String get settingsLimitLabel => 'Limit';

  @override
  String get settingsLimitHint => 'e.g. 5000';

  @override
  String get settingsBudgetSaved => 'Budget limit saved';

  @override
  String get settingsEnterLimit => 'Please enter a limit';

  @override
  String get settingsEnterValidAmount => 'Enter a valid amount';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsCurrency => 'Currency';

  @override
  String get settingsSelectCurrency => 'Select Currency';

  @override
  String get settingsCurrencyUpdated => 'Currency updated';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsSelectTheme => 'Select Theme';

  @override
  String get settingsThemeUpdated => 'Theme updated';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeSystemDesc => 'Use device theme';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeLightDesc => 'Always use light theme';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeDarkDesc => 'Always use dark theme';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsSelectLanguage => 'Select Language';

  @override
  String get settingsLanguageUpdated => 'Language updated';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsPrivacyValue => 'All data on your device';

  @override
  String get settingsInternet => 'Internet';

  @override
  String get settingsInternetValue => 'Not used';

  @override
  String get settingsClearAllData => 'Clear All Data';

  @override
  String get settingsClearAllDataTitle => 'Clear All Data';

  @override
  String get settingsClearAllDataDesc =>
      'All your expense records will be permanently deleted. This action cannot be undone.';

  @override
  String get settingsAllDataDeleted => 'All data deleted';

  @override
  String get addExpenseTitle => 'Add Expense';

  @override
  String get addExpenseTitleLabel => 'Expense Title';

  @override
  String get addExpenseTitleHint => 'e.g. Dinner';

  @override
  String get addExpenseEnterTitle => 'Please enter a title';

  @override
  String get addExpenseAmount => 'Amount';

  @override
  String get addExpenseAmountHint => 'e.g. 150';

  @override
  String get addExpenseEnterAmount => 'Please enter an amount';

  @override
  String get addExpenseEnterValidAmount => 'Enter a valid amount';

  @override
  String get addExpenseCategory => 'Category';

  @override
  String get editExpenseTitle => 'Edit Expense';

  @override
  String get editExpenseDeleteTitle => 'Delete Expense';

  @override
  String get editExpenseDeleteConfirm =>
      'Are you sure you want to delete this expense?';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingGetStarted => 'Let\'s Get Started';

  @override
  String get onboarding1Title => 'Welcome to BBuddy';

  @override
  String get onboarding1Desc =>
      'Easily record your expenses and track your budget. Completely free, completely private.';

  @override
  String get onboarding2Title => 'Set Your Budget';

  @override
  String get onboarding2Desc =>
      'Set your own monthly budget limit. The app will warn you when you\'re close to your limit.';

  @override
  String get onboarding3Title => 'Analyze Your Expenses';

  @override
  String get onboarding3Desc =>
      'Visually track where your money goes with category-based charts.';

  @override
  String get navHome => 'Home';

  @override
  String get navStats => 'Statistics';

  @override
  String get categoryFood => 'Food';

  @override
  String get categoryTransport => 'Transport';

  @override
  String get categoryEntertainment => 'Entertainment';

  @override
  String get categoryGrocery => 'Grocery';

  @override
  String get categoryBills => 'Bills';

  @override
  String get categoryOther => 'Other';

  @override
  String get languageTurkish => 'Turkish';

  @override
  String get languageTurkishRegion => 'Turkey';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageEnglishRegion => 'United States';
}
