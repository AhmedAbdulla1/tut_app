import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tut_app/presentation/on_boarding/widget/on_boarding_body.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
        ),
      ),
      backgroundColor: ColorManager.white,
      body: const OnBoardingBody(),
    );
  }
}
