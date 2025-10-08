import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FocusnotesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color color;
  final bool hasLeading;
  const FocusnotesAppBar({
    super.key,
    required this.color,
    required this.title,
    this.hasLeading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AppBar(
        leading: hasLeading
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.chevron_left),
              )
            : null,
        automaticallyImplyLeading: false,
        title: Center(child: Text(title)),
        backgroundColor: color,
      );
    } else {
      return CupertinoNavigationBar(
        leading: hasLeading
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.chevron_left),
              )
            : null,
        automaticallyImplyLeading: false,
        middle: Center(child: Text(title)),
        backgroundColor: color,
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
