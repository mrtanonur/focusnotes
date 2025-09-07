import 'package:flutter/material.dart';
import 'package:focusnotes/l10n/app_localizations.dart';
import 'package:focusnotes/providers/main_provider.dart';
import 'package:focusnotes/widgets/focusnotes_appbar.dart';
import 'package:provider/provider.dart';

import '../utils/constants/constants.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FocusnotesAppBar(
        hasLeading: true,
        color: Theme.of(context).colorScheme.surfaceBright,
        title: AppLocalizations.of(context)!.language,
      ),
      body: Padding(
        padding: const EdgeInsets.all(SizeConstants.s24),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox.adaptive(
                  value: context.watch<MainProvider>().language == Languages.en,
                  onChanged: (value) {
                    context.read<MainProvider>().changeLanguage(Languages.en);
                  },
                ),
                SizedBox(width: SizeConstants.s12),
                Text("English"),
              ],
            ),
            Row(
              children: [
                Checkbox.adaptive(
                  value: context.watch<MainProvider>().language == Languages.tr,
                  onChanged: (value) {
                    context.read<MainProvider>().changeLanguage(Languages.tr);
                  },
                ),
                SizedBox(width: SizeConstants.s12),
                Text("Turkish"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
