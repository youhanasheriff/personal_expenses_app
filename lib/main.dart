import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import './local_storage/shared_preferences.dart';
import './my_app.dart';
import './translations/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await TransactionSharedPreferences.init();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), //Arabic
        Locale('ta') // Tamil,
      ],
      path: 'lib/lang', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MyApp(),
    ),
  );
}
