import 'dart:async';

import 'package:flutter/material.dart';
import 'package:focusnotes/pages/home_page.dart';
import 'package:focusnotes/pages/sign_up_page.dart';
import 'package:focusnotes/providers/auth_provider.dart';
import 'package:focusnotes/utils/constants/asset_constants.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthProvider? _provider;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _provider = context.read<AuthProvider>();
    _timer = Timer(Duration(seconds: 2), () async {
      if (await _provider!.authCheck()) {
        _provider!.getUserData();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SignUpPage()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceBright,
      body: Center(child: Image.asset(AssetConstants.focusnotesTransparent)),
    );
  }
}
