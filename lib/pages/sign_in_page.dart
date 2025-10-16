import 'package:flutter/material.dart';
import 'package:focusnotes/l10n/app_localizations.dart';
import 'package:focusnotes/pages/forgot_password.dart';
import 'package:focusnotes/pages/home_page.dart';
import 'package:focusnotes/pages/sign_up_page.dart';
import 'package:focusnotes/providers/auth_provider.dart';
import 'package:focusnotes/widgets/focusnotes_button.dart';
import 'package:focusnotes/widgets/focusnotes_textformfield.dart';
import 'package:provider/provider.dart';

import '../utils/constants/constants.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
    final status = context.read<AuthProvider>().status;

    if (status == AuthStatus.signIn) {
      _provider!.getUserData();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } else if (status == AuthStatus.unVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.verifyYourEmail)),
      );
    } else if (status == AuthStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.error)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AssetConstants.focusnotesTransparent,
                  height: SizeConstants.s200,
                ),
                SizedBox(height: SizeConstants.s48),

                SignInForm(),
                SizedBox(height: SizeConstants.s100),
                GoogleAppleSignIn(),
                SizedBox(height: SizeConstants.s48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.ifYouDontHaveAnAccount),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: Text(AppLocalizations.of(context)!.signUp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            hintText: "Email",
          ),
          FocusNotesTextFormfield(
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.enterYourPassword;
              }
              return null;
            },
            controller: _passwordController,
            hintText: "Password",
          ),
          Padding(
            padding: const EdgeInsets.only(right: SizeConstants.s12),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.forgotPassword),
                ),
              ],
            ),
          ),
          FocusNotesButton(
            isLoading: isLoading,
            onTap: () async {
              if (_globalKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                });

                await context.read<AuthProvider>().signIn(
                  _emailController.text,
                  _passwordController.text,
                );

                setState(() {
                  isLoading = false;
                });
              }
            },
            text: AppLocalizations.of(context)!.signIn,
          ),
        ],
      ),
    );
  }
}

class GoogleAppleSignIn extends StatefulWidget {
  const GoogleAppleSignIn({super.key});

  @override
  State<GoogleAppleSignIn> createState() => _GoogleAppleSignInState();
}

class _GoogleAppleSignInState extends State<GoogleAppleSignIn> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AssetConstants.appleLogo, height: 50),
        SizedBox(width: SizeConstants.s48),
        Image.asset(AssetConstants.googleLogo, height: 54),
      ],
    );
  }
}
