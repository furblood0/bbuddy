import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/expense_provider.dart';
import '../../providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _limitController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final currentLimit = context.read<ExpenseProvider>().budgetLimit;
    _limitController =
        TextEditingController(text: currentLimit.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _limitController.dispose();
    super.dispose();
  }

  Future<void> _saveLimit(AppLocalizations l) async {
    if (!_formKey.currentState!.validate()) return;
    final newLimit =
        double.tryParse(_limitController.text.replaceAll(',', '.')) ?? 5000.0;
    await context.read<ExpenseProvider>().updateLimit(newLimit);
    if (!mounted) return;
    _showSnackBar(l.settingsBudgetSaved);
    Navigator.of(context).pop();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showCurrencyPicker(AppLocalizations l) {
    final settings = context.read<SettingsProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  l.settingsSelectCurrency,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: SettingsProvider.currencies.map((currency) {
                      final isSelected =
                          settings.currencySymbol == currency['symbol'];
                      return ListTile(
                        onTap: () {
                          settings.updateCurrency(currency['symbol']!);
                          Navigator.of(ctx).pop();
                          _showSnackBar(l.settingsCurrencyUpdated);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        leading: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primaryContainer
                                : Theme.of(context)
                                    .colorScheme
                                    .surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              currency['symbol']!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                        title: Text(currency['name']!,
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                        subtitle: Text(currency['code']!),
                        trailing: isSelected
                            ? Icon(Icons.check_circle,
                                color: Theme.of(context).colorScheme.primary)
                            : null,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showThemePicker(AppLocalizations l) {
    final settings = context.read<SettingsProvider>();
    final themes = [
      {
        'mode': ThemeMode.system,
        'name': l.settingsThemeSystem,
        'desc': l.settingsThemeSystemDesc,
        'icon': Icons.brightness_auto_outlined,
      },
      {
        'mode': ThemeMode.light,
        'name': l.settingsThemeLight,
        'desc': l.settingsThemeLightDesc,
        'icon': Icons.light_mode_outlined,
      },
      {
        'mode': ThemeMode.dark,
        'name': l.settingsThemeDark,
        'desc': l.settingsThemeDarkDesc,
        'icon': Icons.dark_mode_outlined,
      },
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l.settingsSelectTheme,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...themes.map((theme) {
                final isSelected = settings.themeMode == theme['mode'];
                final icon = theme['icon'] as IconData;
                return ListTile(
                  onTap: () {
                    settings.updateThemeMode(theme['mode'] as ThemeMode);
                    Navigator.of(ctx).pop();
                    _showSnackBar(l.settingsThemeUpdated);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      size: 22,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  title: Text(theme['name'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(theme['desc'] as String),
                  trailing: isSelected
                      ? Icon(Icons.check_circle,
                          color: Theme.of(context).colorScheme.primary)
                      : null,
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showLanguagePicker(AppLocalizations l) {
    final settings = context.read<SettingsProvider>();
    final languages = [
      {
        'locale': const Locale('tr'),
        'name': 'Türkçe',
        'region': 'Türkiye',
        'flag': '🇹🇷',
      },
      {
        'locale': const Locale('en'),
        'name': 'English',
        'region': 'United States',
        'flag': '🇺🇸',
      },
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l.settingsSelectLanguage,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...languages.map((lang) {
                final locale = lang['locale'] as Locale;
                final isSelected =
                    settings.locale.languageCode == locale.languageCode;
                return ListTile(
                  onTap: () {
                    settings.updateLocale(locale);
                    Navigator.of(ctx).pop();
                    _showSnackBar(l.settingsLanguageUpdated);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        lang['flag'] as String,
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  title: Text(lang['name'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(lang['region'] as String),
                  trailing: isSelected
                      ? Icon(Icons.check_circle,
                          color: Theme.of(context).colorScheme.primary)
                      : null,
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showClearDataDialog(AppLocalizations l) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.settingsClearAllDataTitle),
        content: Text(l.settingsClearAllDataDesc),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l.cancel),
          ),
          FilledButton(
            onPressed: () async {
              final dialogNav = Navigator.of(ctx);
              final screenNav = Navigator.of(context);
              await context.read<ExpenseProvider>().clearAllExpenses();
              if (!mounted) return;
              dialogNav.pop();
              screenNav.pop();
              _showSnackBar(l.settingsAllDataDeleted);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: Text(l.delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final settings = context.watch<SettingsProvider>();

    String themeLabel;
    if (settings.themeMode == ThemeMode.light) {
      themeLabel = l.settingsThemeLight;
    } else if (settings.themeMode == ThemeMode.dark) {
      themeLabel = l.settingsThemeDark;
    } else {
      themeLabel = l.settingsThemeSystem;
    }

    final langLabel = settings.locale.languageCode == 'en' ? 'English' : 'Türkçe';

    return Scaffold(
      appBar: AppBar(
        title: Text(l.settingsTitle),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader(context, l.settingsBudget),
              const SizedBox(height: 12),
              _buildCard(
                colorScheme,
                child: Column(
                  children: [
                    _buildTileWithIcon(
                      context,
                      icon: Icons.account_balance_wallet_outlined,
                      color: colorScheme.primary,
                      title: l.settingsMonthlyBudgetLimit,
                      subtitle: l.settingsMonthlyBudgetDesc,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _limitController,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      decoration: InputDecoration(
                        hintText: l.settingsLimitHint,
                        suffixText: settings.currencySymbol,
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide:
                              BorderSide(color: colorScheme.primary, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l.settingsEnterLimit;
                        }
                        final amount =
                            double.tryParse(value.replaceAll(',', '.'));
                        if (amount == null || amount <= 0) {
                          return l.settingsEnterValidAmount;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton.icon(
                        onPressed: () => _saveLimit(l),
                        icon: const Icon(Icons.save_outlined, size: 18),
                        label: Text(l.save),
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _sectionHeader(context, l.settingsAppearance),
              const SizedBox(height: 12),
              _buildCard(
                colorScheme,
                child: Column(
                  children: [
                    _buildActionTile(
                      context,
                      icon: Icons.currency_exchange_outlined,
                      color: Colors.green,
                      title: l.settingsCurrency,
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          settings.currencySymbol,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      onTap: () => _showCurrencyPicker(l),
                    ),
                    Divider(
                        height: 1,
                        indent: 54,
                        endIndent: 20,
                        color: colorScheme.outlineVariant.withValues(alpha: 0.4)),
                    _buildActionTile(
                      context,
                      icon: Icons.dark_mode_outlined,
                      color: Colors.orange,
                      title: l.settingsTheme,
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          themeLabel,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      onTap: () => _showThemePicker(l),
                    ),
                    Divider(
                        height: 1,
                        indent: 54,
                        endIndent: 20,
                        color: colorScheme.outlineVariant.withValues(alpha: 0.4)),
                    _buildActionTile(
                      context,
                      icon: Icons.language_outlined,
                      color: Colors.blue,
                      title: l.settingsLanguage,
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          langLabel,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      onTap: () => _showLanguagePicker(l),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _sectionHeader(context, l.settingsAbout),
              const SizedBox(height: 12),
              _buildCard(
                colorScheme,
                child: Column(
                  children: [
                    _buildInfoTile(context,
                        icon: Icons.info_outline,
                        title: l.settingsVersion,
                        trailing: '1.0.0'),
                    Divider(
                        height: 1,
                        indent: 54,
                        endIndent: 20,
                        color: colorScheme.outlineVariant.withValues(alpha: 0.4)),
                    _buildInfoTile(context,
                        icon: Icons.lock_outline,
                        title: l.settingsPrivacy,
                        trailing: l.settingsPrivacyValue),
                    Divider(
                        height: 1,
                        indent: 54,
                        endIndent: 20,
                        color: colorScheme.outlineVariant.withValues(alpha: 0.4)),
                    _buildInfoTile(context,
                        icon: Icons.wifi_off_outlined,
                        title: l.settingsInternet,
                        trailing: l.settingsInternetValue),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () => _showClearDataDialog(l),
                  icon: const Icon(Icons.delete_forever_outlined,
                      color: Colors.red),
                  label: Text(l.settingsClearAllData,
                      style: const TextStyle(color: Colors.red)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title, {Color? color}) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color ?? Theme.of(context).colorScheme.primary,
            letterSpacing: 0.5,
          ),
    );
  }

  Widget _buildCard(ColorScheme colorScheme, {required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }

  Widget _buildTileWithIcon(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 15)),
            Text(subtitle,
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.outline)),
          ],
        ),
      ],
    );
  }

  Widget _buildActionTile(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 15)),
            ),
            trailing,
            const SizedBox(width: 4),
            Icon(Icons.chevron_right,
                size: 20, color: colorScheme.outline),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String trailing,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: colorScheme.outline),
          const SizedBox(width: 14),
          Text(title,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(trailing,
              style:
                  TextStyle(fontSize: 13, color: colorScheme.outline)),
        ],
      ),
    );
  }
}
