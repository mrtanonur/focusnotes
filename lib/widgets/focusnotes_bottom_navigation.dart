import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focusnotes/l10n/app_localizations.dart';
import 'package:focusnotes/providers/main_provider.dart';
import 'package:provider/provider.dart';

class FocusNotesBottomNavigation extends StatefulWidget {
  const FocusNotesBottomNavigation({super.key});

  @override
  State<FocusNotesBottomNavigation> createState() =>
      _FocusNotesBottomNavigationState();
}

class _FocusNotesBottomNavigationState
    extends State<FocusNotesBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomNavigationBar(
        currentIndex: context.watch<MainProvider>().navigationIndex,
        onTap: (index) {
          context.read<MainProvider>().changeNavigationIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.note,
            icon: Icon(Icons.note),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.settings,
            icon: Icon(Icons.settings),
          ),
        ],
      );
    } else {
      return CupertinoTabBar(
        currentIndex: context.watch<MainProvider>().navigationIndex,
        onTap: (index) {
          context.read<MainProvider>().changeNavigationIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.note,
            icon: Icon(Icons.task),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.settings,
            icon: Icon(Icons.settings),
          ),
        ],
      );
    }
  }
}
