import 'package:flutter/material.dart';
import 'package:focusnotes/l10n/app_localizations.dart';

extension ThemeExtension on ThemeMode {
  String localizedText(BuildContext context) {
    switch (this) {
      case ThemeMode.light:
        return AppLocalizations.of(context)!.light;
      case ThemeMode.dark:
        return AppLocalizations.of(context)!.dark;
      case ThemeMode.system:
        return AppLocalizations.of(context)!.system;
    }
  }
}
