import 'package:flutter/material.dart';
import 'package:focusnotes/extensions/theme_extension.dart';
import 'package:focusnotes/l10n/app_localizations.dart';
import 'package:focusnotes/providers/main_provider.dart';
import 'package:focusnotes/widgets/focusnotes_appbar.dart';
import 'package:provider/provider.dart';

import '../utils/constants/constants.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      appBar: FocusnotesAppBar(
        hasLeading: true,
        color: Theme.of(context).colorScheme.surfaceBright,
        title: AppLocalizations.of(context)!.theme,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(SizeConstants.s24),
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox.adaptive(
                    value:
                        context.watch<MainProvider>().themeMode ==
                        ThemeMode.system,
                    onChanged: (value) {
                      context.read<MainProvider>().changeTheme(
                        ThemeMode.system,
                      );
                    },
                  ),
                  Text(ThemeMode.system.localizedText(context)),
                ],
              ),
              Row(
                children: [
                  Checkbox.adaptive(
                    value:
                        context.watch<MainProvider>().themeMode ==
                        ThemeMode.light,
                    onChanged: (value) {
                      context.read<MainProvider>().changeTheme(ThemeMode.light);
                    },
                  ),
                  Text(ThemeMode.light.localizedText(context)),
                ],
              ),
              Row(
                children: [
                  Checkbox.adaptive(
                    value:
                        context.watch<MainProvider>().themeMode ==
                        ThemeMode.dark,
                    onChanged: (value) {
                      context.read<MainProvider>().changeTheme(ThemeMode.dark);
                    },
                  ),
                  Text(ThemeMode.dark.localizedText(context)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
