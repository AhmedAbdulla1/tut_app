import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:tut_app/firebase_options.dart';
import 'package:tut_app/presentation/resources/language_manager.dart';

import 'app/app.dart';
import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initAppModule();
  runApp(EasyLocalization(
    supportedLocales: const [arabicLocale, englishLocale],
    path: assetPathLocalizations,
    child: Phoenix(
      child: MyApp(),
    ),
  ));
}
