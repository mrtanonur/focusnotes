import 'package:flutter/material.dart';
import 'package:focusnotes/l10n/app_localizations.dart';
import 'package:focusnotes/pages/email_verification.page.dart';
import 'package:focusnotes/pages/sign_in_page.dart';
import 'package:focusnotes/providers/auth_provider.dart';
import 'package:focusnotes/widgets/focusnotes_button.dart';
import 'package:focusnotes/widgets/focusnotes_textformfield.dart';
import 'package:provider/provider.dart';

import '../utils/constants/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AuthProvider? _provider;
  @override
  void initState() {
    super.initState();
    _provider = context.read<AuthProvider>();
    _provider!.addListener(_authListener);
  }

  @override
  void dispose() {
    _provider!.removeListener(_authListener);
    super.dispose();
  }

  void _authListener() {
    AuthStatus status = _provider!.status;
    if (status == AuthStatus.verificationProcess) {
      _provider!.storeUserData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EmailVerificationPage()),
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

                SignUpForm(),
                SizedBox(height: SizeConstants.s100),
                GoogleAppleSignIn(),
                SizedBox(height: SizeConstants.s48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.ifYouHaveAnAccount),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      },
                      child: Text(AppLocalizations.of(context)!.signIn),
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

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          FocusNotesTextFormfield(
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.enterYourPassword;
              }
              return null;
            },
            controller: _passwordController,
            hintText: AppLocalizations.of(context)!.password,
          ),
          FocusNotesTextFormfield(
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.enterConfirmPassword;
              }
              return null;
            },
            controller: _confirmPasswordController,
            hintText: AppLocalizations.of(context)!.confirmPassword,
          ),
          FocusNotesButton(
            isLoading: isLoading,
            onTap: () async {
              print(_emailController.text);
              if (_globalKey.currentState!.validate()) {
                if (_confirmPasswordController.text ==
                    _passwordController.text) {
                  setState(() {
                    isLoading = true;
                  });
                  await context.read<AuthProvider>().signUp(
                    _emailController.text,
                    _passwordController.text,
                  );
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!.passwordsDoNotMatch,
                      ),
                    ),
                  );
                }
              }
            },
            text: AppLocalizations.of(context)!.signUp,
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
        Image.asset("assets/images/apple_logo.png", height: 50),
        SizedBox(width: SizeConstants.s48),
        Image.asset("assets/images/google_logo.png", height: 54),
      ],
    );
  }
}
