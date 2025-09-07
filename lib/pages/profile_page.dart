import 'package:flutter/material.dart';
import 'package:focusnotes/l10n/app_localizations.dart';
import 'package:focusnotes/providers/auth_provider.dart';
import 'package:focusnotes/widgets/focusnotes_appbar.dart';
import 'package:provider/provider.dart';

import '../utils/constants/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FocusnotesAppBar(
        hasLeading: true,
        color: Theme.of(context).colorScheme.surfaceBright,
        title: AppLocalizations.of(context)!.profile,
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SizeConstants.s48),
        child: Column(
          children: [
            const SizedBox(height: SizeConstants.s36),
            const Icon(Icons.person, size: SizeConstants.s100),
            const SizedBox(height: SizeConstants.s48),
            profileTile(
              AppLocalizations.of(context)!.email,
              context.read<AuthProvider>().userData!.email,
            ),
          ],
        ),
      ),
    );
  }
}

Widget profileTile(String leftText, String rightText) {
  return Row(
    children: [
      Text(
        leftText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: SizeConstants.s16,
        ),
      ),
      const Spacer(),
      Text(rightText),
    ],
  );
}
