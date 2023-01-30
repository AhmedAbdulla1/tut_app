import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/constant.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  Timer? _timer;

  _startTimer() {
    _timer = Timer(
      const Duration(
        seconds: AppConstant.timer,
      ),
      () async {
        // if (await _appPreferences.isPressKeyLoginScreen()) {
        //   Navigator.pushReplacementNamed(context, Routes.mainScreen);
        // } else if (await _appPreferences.isPressKeyOnBoardingScreen()) {
        //   Navigator.pushReplacementNamed(context, Routes.loginScreen);
        // } else {
          Navigator.pushReplacementNamed(context, Routes.onBoardingScreen);
        // }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image.asset(
          ImageAssets.splashLogo,
        ),
      ),
    );
  }
}
