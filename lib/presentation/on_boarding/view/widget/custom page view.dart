import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'custom item.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({Key? key,required this.pageController}) : super(key: key);
  final  PageController?pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        CustomView(
          image: ImageAssets.onBoardingLogo1,
          title: AppStrings.onBoardingTitle1,
          subTitle:  AppStrings.onBoardingSubTitle1,
        ),
        CustomView(
          image: ImageAssets.onBoardingLogo2,
          title: AppStrings.onBoardingTitle2,
          subTitle:  AppStrings.onBoardingSubTitle2,
        ),
        CustomView(
          image: ImageAssets.onBoardingLogo3,
          title: AppStrings.onBoardingTitle3,
          subTitle:  AppStrings.onBoardingSubTitle3,
        ),
        CustomView(
          image: ImageAssets.onBoardingLogo4,
          title: AppStrings.onBoardingTitle4,
          subTitle:  AppStrings.onBoardingSubTitle4,
        ),
      ],
    );
  }
}
