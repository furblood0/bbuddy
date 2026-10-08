/// Application version — keep in sync with `version:` in [pubspec.yaml].
abstract final class AppInfo {
  static const String version = '1.0.0';
  static const String buildNumber = '1';

  /// Public copy required by Google Play. Host `docs/privacy-policy.html`
  /// with GitHub Pages before submitting the store listing.
  static const String privacyPolicyUrl =
      'https://furblood0.github.io/bbuddy/privacy-policy.html';

  /// Replace with a mailbox you actually read before publishing.
  static const String contactEmail = 'contact@bbuddy.app';

  static String get versionLabel => '$version+$buildNumber';
}
