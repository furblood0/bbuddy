import 'package:flutter/material.dart';

import '../../core/app_info.dart';
import '../../l10n/app_localizations.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final sections = [
      (l.privacyCollectTitle, l.privacyCollectBody),
      (l.privacyInternetTitle, l.privacyInternetBody),
      (l.privacyBackupTitle, l.privacyBackupBody),
      (l.privacyDeleteTitle, l.privacyDeleteBody),
      (l.privacyContactTitle, l.privacyContactBody(AppInfo.contactEmail)),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l.privacyTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              l.privacyIntro,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.5,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          for (final section in sections) ...[
            const SizedBox(height: 22),
            Text(section.$1, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              section.$2,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.5,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: 22),
          SelectableText(
            AppInfo.privacyPolicyUrl,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: colorScheme.primary),
          ),
        ],
      ),
    );
  }
}
