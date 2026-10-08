// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get update => 'Update';

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
  String get homeNoExpensesTitle => 'No records yet';

  @override
  String get homeNoExpensesSubtitle =>
      'Tap the button below to add your first income or expense';

  @override
  String get homeSwipeToDelete => 'Delete';

  @override
  String get homeExpenseDeleted => 'Expense deleted';

  @override
  String get homeUndo => 'Undo';

  @override
  String get homeRecords => 'Records';

  @override
  String get homeAddRecord => 'Add';

  @override
  String get homeIncome => 'Income';

  @override
  String get homeSpent => 'Spent';

  @override
  String get homeNet => 'Net';

  @override
  String get homeRecordDeleted => 'Record deleted';

  @override
  String get statsTitle => 'Statistics';

  @override
  String get statsNoDataTitle => 'No data to show yet';

  @override
  String get statsNoDataSubtitle =>
      'Charts appear here as you add income or expenses';

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
  String get statsSelectMonth => 'Select Month';

  @override
  String get statsPreviousMonth => 'Previous month';

  @override
  String get statsNextMonth => 'Next month';

  @override
  String get statsNoExpenses => 'No expenses this month';

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
      'All income and expense records will be permanently deleted. Your budget limit stays. This cannot be undone.';

  @override
  String get settingsAllDataDeleted => 'All data deleted';

  @override
  String get settingsData => 'Data';

  @override
  String get settingsExport => 'Export backup';

  @override
  String get settingsExportDesc =>
      'Share income, expenses, and your budget limit as a JSON file';

  @override
  String get settingsExportFailed => 'Couldn\'t create the backup';

  @override
  String get settingsImport => 'Import backup';

  @override
  String get settingsImportDesc => 'Load a JSON file you exported earlier';

  @override
  String get settingsImportConfirmTitle => 'Import this backup?';

  @override
  String settingsImportConfirmBody(int count, String limit) {
    return '$count records will be loaded and the budget limit will be $limit. Your current records will be replaced.';
  }

  @override
  String get settingsImportDone => 'Backup imported';

  @override
  String get settingsImportInvalid => 'This file isn\'t a valid BBuddy backup';

  @override
  String get settingsImportVersion =>
      'This backup is from a newer version. Update the app.';

  @override
  String get settingsImportEmpty => 'The file is empty';

  @override
  String get addExpenseTitle => 'Add Expense';

  @override
  String get addExpenseTitleLabel => 'Note (optional)';

  @override
  String get addExpenseTitleHint => 'e.g. Dinner with friends';

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
  String get addExpenseDate => 'Date';

  @override
  String get kindExpense => 'Expense';

  @override
  String get kindIncome => 'Income';

  @override
  String get addIncomeTitle => 'Add Income';

  @override
  String get addIncomeTitleHint => 'e.g. October allowance';

  @override
  String get editExpenseTitle => 'Edit Expense';

  @override
  String get editExpenseDeleteTitle => 'Delete Expense';

  @override
  String get editExpenseDeleteConfirm =>
      'Are you sure you want to delete this expense?';

  @override
  String get editIncomeTitle => 'Edit Income';

  @override
  String get editIncomeDeleteTitle => 'Delete Income';

  @override
  String get editIncomeDeleteConfirm =>
      'Are you sure you want to delete this income?';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingGetStarted => 'Let\'s Get Started';

  @override
  String get onboardingSetBudget => 'Set my budget';

  @override
  String get onboarding1Title => 'Welcome to BBuddy';

  @override
  String get onboarding1Desc =>
      'Easily record your expenses and track your budget. Completely free, completely private.';

  @override
  String get onboarding2Title => 'Set Your Budget';

  @override
  String get onboarding2Desc =>
      'Set your own monthly spending limit. The home screen shows what\'s left and how much you\'ve used.';

  @override
  String get onboarding3Title => 'Analyze Your Spending';

  @override
  String get onboarding3Desc =>
      'See where your money goes with category charts.';

  @override
  String get budgetSetupTitle => 'What\'s your monthly budget?';

  @override
  String get budgetSetupSubtitle =>
      'This is how much you plan to spend this month. You can log income separately and change the limit later in Settings.';

  @override
  String get budgetSetupContinue => 'Start';

  @override
  String get navHome => 'Home';

  @override
  String get navStats => 'Statistics';

  @override
  String get categoryFood => 'Food';

  @override
  String get categoryGrocery => 'Grocery';

  @override
  String get categoryTransport => 'Transport';

  @override
  String get categoryEducation => 'Education';

  @override
  String get categoryHealth => 'Health';

  @override
  String get categorySubscription => 'Subscription';

  @override
  String get categoryHousing => 'Housing';

  @override
  String get categoryEntertainment => 'Entertainment';

  @override
  String get categoryBills => 'Bills';

  @override
  String get categoryOther => 'Other';

  @override
  String get categoryAllowance => 'Allowance';

  @override
  String get categoryScholarship => 'Scholarship';

  @override
  String get categoryJob => 'Work';

  @override
  String get categoryFamily => 'Family';

  @override
  String get privacyTitle => 'Privacy Policy';

  @override
  String get privacyIntro =>
      'BBuddy works entirely offline. What you enter stays on your device.';

  @override
  String get privacyCollectTitle => 'Data we collect';

  @override
  String get privacyCollectBody =>
      'BBuddy collects no personal data. Expenses, income, your budget limit, and theme and language preferences are stored only on your device.';

  @override
  String get privacyInternetTitle => 'Internet';

  @override
  String get privacyInternetBody =>
      'The app does not request internet access and does not connect to a server. There is no account, no advertising, and no analytics.';

  @override
  String get privacyBackupTitle => 'Backup file';

  @override
  String get privacyBackupBody =>
      'Exporting a backup creates a JSON file on your device. That file goes to another app only if you choose to share it.';

  @override
  String get privacyDeleteTitle => 'Deleting your data';

  @override
  String get privacyDeleteBody =>
      'You can delete all income and expense records from Settings, or uninstall the app. Uninstalling also removes the data left on the device.';

  @override
  String get privacyContactTitle => 'Contact';

  @override
  String privacyContactBody(String email) {
    return 'Questions: $email';
  }

  @override
  String get languageTurkish => 'Turkish';

  @override
  String get languageTurkishRegion => 'Turkey';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageEnglishRegion => 'United States';
}
