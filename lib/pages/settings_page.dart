import 'package:flutter/material.dart';
import 'package:focusnotes/l10n/app_localizations.dart';
import 'package:focusnotes/pages/language_page.dart';
import 'package:focusnotes/pages/profile_page.dart';
import 'package:focusnotes/pages/sign_in_page.dart';
import 'package:focusnotes/pages/theme_page.dart';
import 'package:focusnotes/providers/auth_provider.dart';
import 'package:focusnotes/providers/main_provider.dart';
import 'package:focusnotes/utils/constants/constants.dart';
import 'package:focusnotes/widgets/focusnotes_appbar.dart';
import 'package:focusnotes/widgets/focusnotes_button.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AuthProvider? _provider;
  @override
  void initState() {
    super.initState();
    _provider = context.read<AuthProvider>();

    _provider!.addListener(authListener);
  }

  @override
  void dispose() {
    _provider!.removeListener(authListener);
    super.dispose();
  }

  void authListener() {
    final status = context.read<AuthProvider>().status;
    if (status == AuthStatus.signOut) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      appBar: FocusnotesAppBar(
        color: Theme.of(context).colorScheme.surfaceBright,
        title: AppLocalizations.of(context)!.settings,
      ),
      body: Padding(
        padding: const EdgeInsets.all(SizeConstants.s24),
        child: Column(
          children: [
            SettingsTile(
              page: ProfilePage(),
              icon: Icons.person,
              text: AppLocalizations.of(context)!.profile,
            ),

            SettingsTile(
              page: ThemePage(),
              icon: Icons.contrast,
              text: AppLocalizations.of(context)!.theme,
            ),

            SettingsTile(
              page: LanguagePage(),
              icon: Icons.language,
              text: AppLocalizations.of(context)!.language,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: SizeConstants.s24),
              child: FocusNotesButton(
                onTap: () async {
                  await context.read<AuthProvider>().signOut();
                  context.read<MainProvider>().resetNavigationIndex();
                },
                text: "Sign Out",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final Widget page;
  final IconData icon;
  final String text;
  const SettingsTile({
    super.key,
    required this.page,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      leading: Icon(icon),
      title: Text(text),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
