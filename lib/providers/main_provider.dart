import 'package:flutter/material.dart';
import 'package:focusnotes/local_data_source/main_local_data_source.dart';

enum Languages { tr, en }

class MainProvider extends ChangeNotifier {
  int navigationIndex = 0;

  void resetNavigationIndex() {
    navigationIndex = 0;
  }

  Languages language = Languages.values.firstWhere(
    (language) =>
        language.name ==
        (MainLocalDataSource.read("language") ?? Languages.en.name),
  );

  ThemeMode themeMode = ThemeMode.values.firstWhere(
    (theme) =>
        theme.name ==
        (MainLocalDataSource.read("theme") ?? ThemeMode.system.name),
  );

  void changeNavigationIndex(int index) {
    navigationIndex = index;
    notifyListeners();
  }

  void changeLanguage(Languages selectedLanguage) async {
    language = selectedLanguage;
    await MainLocalDataSource.add("language", language.name);
    notifyListeners();
  }

  void changeTheme(ThemeMode theme) async {
    themeMode = theme;
    await MainLocalDataSource.add("theme", theme.name);
    notifyListeners();
  }
}
