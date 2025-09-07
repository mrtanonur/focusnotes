import 'package:flutter/material.dart';
import 'package:focusnotes/l10n/app_localizations.dart';
import 'package:focusnotes/pages/sign_in_page.dart';
import 'package:focusnotes/providers/auth_provider.dart';
import 'package:focusnotes/utils/constants/constants.dart';
import 'package:focusnotes/widgets/focusnotes_appbar.dart';
import 'package:focusnotes/widgets/focusnotes_button.dart';
import 'package:focusnotes/widgets/focusnotes_textformfield.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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

  void authListener() async {
    AuthStatus status = _provider!.status;
    if (status == AuthStatus.resetPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.passwordResetLinkIsSent),
        ),
      );
    } else if (status == AuthStatus.failure) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(_provider!.error!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FocusnotesAppBar(
        color: Theme.of(context).colorScheme.surfaceBright,
        title: "Reset Password",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetConstants.focusnotesTransparent,
            height: SizeConstants.s200,
          ),
          Text(
            AppLocalizations.of(
              context,
            )!.enterYourEmailInOrderToGetResetPasswordLink,
          ),
          ForgotPasswordForm(),
          SizedBox(height: SizeConstants.s48),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            child: Text(AppLocalizations.of(context)!.signInPage),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: Column(
        children: [
          FocusNotesTextFormfield(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.enterYourEmail;
              }
              return null;
            },
            controller: _emailController,
            hintText: AppLocalizations.of(context)!.email,
          ),
          FocusNotesButton(
            onTap: () {
              if (_globalKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                });
                context.read<AuthProvider>().sendPasswordResetLink(
                  _emailController.text,
                );
                setState(() {
                  isLoading = false;
                });
              }
            },
            isLoading: isLoading,
            text: AppLocalizations.of(context)!.sendPasswordResetLink,
          ),
        ],
      ),
    );
  }
}
