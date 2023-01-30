import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/firebase_options.dart';

import 'app/app.dart';
import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initAppModule();
  runApp(MyApp());
}
