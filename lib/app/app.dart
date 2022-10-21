import 'package:flutter/material.dart';
import 'package:tut_app/presentation/theme_manager.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();
  static final MyApp _instance =
  MyApp._internal();

  factory MyApp()=>_instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
      home: Scaffold(),
    );
  }
}
