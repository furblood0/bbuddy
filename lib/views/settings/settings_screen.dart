import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  Future<void> _saveLimit() async {
    if (!_formKey.currentState!.validate()) return;
    final newLimit =
        double.tryParse(_limitController.text.replaceAll(',', '.')) ?? 5000.0;
    await context.read<ExpenseProvider>().updateLimit(newLimit);
    if (!mounted) return;
    _showSnackBar('Bütçe limiti kaydedildi');
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

  void _showCurrencyPicker() {
    final settings = context.read<SettingsProvider>();
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
                'Para Birimi Seç',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...SettingsProvider.currencies.map((currency) {
                final isSelected =
                    settings.currencySymbol == currency['symbol'];
                return ListTile(
                  onTap: () {
                    settings.updateCurrency(currency['symbol']!);
                    Navigator.of(ctx).pop();
                    _showSnackBar('Para birimi güncellendi');
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
              }),
            ],
          ),
        );
      },
    );
  }

  void _showClearDataDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tüm Verileri Sil'),
        content: const Text(
          'Tüm harcama kayıtların kalıcı olarak silinecek. Bu işlem geri alınamaz.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('İptal'),
          ),
          FilledButton(
            onPressed: () async {
              final dialogNav = Navigator.of(ctx);
              final screenNav = Navigator.of(context);
              await context.read<ExpenseProvider>().clearAllExpenses();
              if (!mounted) return;
              dialogNav.pop();
              screenNav.pop();
              _showSnackBar('Tüm veriler silindi');
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader(context, 'Bütçe'),
              const SizedBox(height: 12),
              _buildCard(
                colorScheme,
                child: Column(
                  children: [
                    _buildTileWithIcon(
                      context,
                      icon: Icons.account_balance_wallet_outlined,
                      color: colorScheme.primary,
                      title: 'Aylık Bütçe Limiti',
                      subtitle: 'Bu ay için maksimum harcama tutarı',
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _limitController,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Limit',
                        hintText: 'ör. 5000',
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
                          return 'Lütfen bir limit girin';
                        }
                        final amount =
                            double.tryParse(value.replaceAll(',', '.'));
                        if (amount == null || amount <= 0) {
                          return 'Geçerli bir tutar girin';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton.icon(
                        onPressed: _saveLimit,
                        icon: const Icon(Icons.save_outlined, size: 18),
                        label: const Text('Kaydet'),
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
              _sectionHeader(context, 'Görünüm'),
              const SizedBox(height: 12),
              _buildCard(
                colorScheme,
                child: Column(
                  children: [
                    _buildActionTile(
                      context,
                      icon: Icons.currency_exchange_outlined,
                      color: Colors.green,
                      title: 'Para Birimi',
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
                      onTap: _showCurrencyPicker,
                    ),
                    Divider(
                        height: 1,
                        indent: 54,
                        endIndent: 20,
                        color: colorScheme.outlineVariant.withValues(alpha: 0.4)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      Colors.orange.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                    Icons.dark_mode_outlined,
                                    color: Colors.orange,
                                    size: 20),
                              ),
                              const SizedBox(width: 14),
                              const Text(
                                'Tema',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          SegmentedButton<ThemeMode>(
                            segments: const [
                              ButtonSegment(
                                value: ThemeMode.system,
                                label: Text('Sistem'),
                                icon: Icon(Icons.brightness_auto_outlined,
                                    size: 16),
                              ),
                              ButtonSegment(
                                value: ThemeMode.light,
                                label: Text('Açık'),
                                icon: Icon(Icons.light_mode_outlined,
                                    size: 16),
                              ),
                              ButtonSegment(
                                value: ThemeMode.dark,
                                label: Text('Koyu'),
                                icon: Icon(Icons.dark_mode_outlined,
                                    size: 16),
                              ),
                            ],
                            selected: {settings.themeMode},
                            onSelectionChanged: (modes) =>
                                settings.updateThemeMode(modes.first),
                            style: const ButtonStyle(
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _sectionHeader(context, 'Hakkında'),
              const SizedBox(height: 12),
              _buildCard(
                colorScheme,
                child: Column(
                  children: [
                    _buildInfoTile(context,
                        icon: Icons.info_outline,
                        title: 'Versiyon',
                        trailing: '1.0.0'),
                    Divider(
                        height: 1,
                        indent: 54,
                        endIndent: 20,
                        color: colorScheme.outlineVariant.withValues(alpha: 0.4)),
                    _buildInfoTile(context,
                        icon: Icons.lock_outline,
                        title: 'Gizlilik',
                        trailing: 'Tüm veriler cihazında'),
                    Divider(
                        height: 1,
                        indent: 54,
                        endIndent: 20,
                        color: colorScheme.outlineVariant.withValues(alpha: 0.4)),
                    _buildInfoTile(context,
                        icon: Icons.wifi_off_outlined,
                        title: 'İnternet',
                        trailing: 'Kullanılmıyor'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _sectionHeader(context, 'Tehlike Bölgesi',
                  color: Colors.red),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: _showClearDataDialog,
                  icon: const Icon(Icons.delete_forever_outlined,
                      color: Colors.red),
                  label: const Text('Tüm Verileri Sil',
                      style: TextStyle(color: Colors.red)),
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

  Widget _sectionHeader(BuildContext context, String title,
      {Color? color}) {
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
