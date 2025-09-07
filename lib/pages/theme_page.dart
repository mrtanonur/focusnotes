import 'package:flutter/material.dart';
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
        title: "Theme",
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
                  Text(ThemeMode.system.name),
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
                  Text(ThemeMode.light.name),
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
                  Text(ThemeMode.dark.name),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
