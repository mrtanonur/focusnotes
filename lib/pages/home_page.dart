import 'package:flutter/material.dart';
import 'package:focusnotes/pages/note_page.dart';
import 'package:focusnotes/pages/settings_page.dart';
import 'package:focusnotes/providers/main_provider.dart';
import 'package:focusnotes/widgets/focusnotes_bottom_navigation.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Widget> pages = [NotePage(), SettingsPage()];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[context.watch<MainProvider>().navigationIndex],
      bottomNavigationBar: FocusNotesBottomNavigation(),
    );
  }
}
