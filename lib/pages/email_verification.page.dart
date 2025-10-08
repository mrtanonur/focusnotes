import 'package:flutter/material.dart';
import 'package:focusnotes/l10n/app_localizations.dart';
import 'package:focusnotes/pages/sign_in_page.dart';
import 'package:focusnotes/providers/auth_provider.dart';
import 'package:focusnotes/utils/constants/constants.dart';
import 'package:focusnotes/widgets/focusnotes_appbar.dart';
import 'package:focusnotes/widgets/focusnotes_button.dart';
import 'package:provider/provider.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      appBar: FocusnotesAppBar(
        color: Theme.of(context).colorScheme.surfaceBright,
        title: AppLocalizations.of(context)!.emailVerification,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SizeConstants.s24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetConstants.focusnotesTransparent),
            Text(
              AppLocalizations.of(context)!.weHaveSentAnEmailForVerification,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: SizeConstants.s48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.haventYouReceivedAnEmail,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await context.read<AuthProvider>().sendEmailVerification();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.sendAgain,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConstants.s96),
            FocusNotesButton(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                );
              },
              text: AppLocalizations.of(context)!.goToSignInPage,
            ),
          ],
        ),
      ),
    );
  }
}
