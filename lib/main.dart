import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:focusnotes/l10n/app_localizations.dart';
import 'package:focusnotes/local_data_source/main_local_data_source.dart';
import 'package:focusnotes/local_data_source/note_local_data_source.dart';
import 'package:focusnotes/models/note_model.dart';
import 'package:focusnotes/pages/splash_page.dart';
import 'package:focusnotes/providers/auth_provider.dart';
import 'package:focusnotes/providers/main_provider.dart';
import 'package:focusnotes/providers/note_provider.dart';
import 'package:focusnotes/utils/themes/dark_theme.dart';
import 'package:focusnotes/utils/themes/light_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NoteModelAdapter());

  await MainLocalDataSource.openBox();
  await NoteLocalDataSource.openBox();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        ChangeNotifierProvider(create: (context) => MainProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<MainProvider>().themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(context.watch<MainProvider>().language.name),
      home: SplashPage(),
    );
  }
}
