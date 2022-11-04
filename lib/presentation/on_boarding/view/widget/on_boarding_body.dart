import 'package:tut_app/presentation/resources/values_manager.dart';

import 'custom page view.dart';
import 'package:flutter/material.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({Key? key}) : super(key: key);

  @override
  State<OnBoardingBody> createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return Stack(
      children: [

        CustomPageView(
          pageController: _pageController,
        ),

        // Visibility(
        //   visible: _pageController!.hasClients && _pageController!.page! >= 1.5
        //       ? false
        //       : true,
        //   child: Positioned(
        //     top: AppPadding.p14,
        //     right: 32,
        //     child: TextButton(
        //       onPressed: () {
        //           //
        //           // () => const LoginScreen(),
        //           // transition: Transition.rightToLeftWithFade,
        //           // duration: const Duration(milliseconds: 400),
        //       },
        //       child: const Text(
        //         'skip>>',
        //         style: TextStyle(
        //           fontSize: 14,
        //           fontFamily: 'Poppins',
        //           color: Color(0xff898989),
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // Positioned(
        //   left: SizeConfig.defaultSize! * 10,
        //   right: SizeConfig.defaultSize! * 10,
        //   bottom: SizeConfig.defaultSize! * 22,
        //   child: DotsIndicator(
        //     decorator: DotsDecorator(
        //       color: Colors.transparent,
        //
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(8),
        //         side:  BorderSide(
        //           width: 2,
        //           color: ,
        //           style: BorderStyle.solid,
        //         ),
        //       ),
        //     ),
        //     dotsCount: 3,
        //     position: _pageController!.hasClients ? _pageController!.page! : 0,
        //   ),
        // ), //DotsIndicator
        // Positioned(
        //   left: SizeConfig.defaultSize! * 10,
        //   right: SizeConfig.defaultSize! * 10,
        //   bottom: SizeConfig.defaultSize! * 9,
        //   child: CustomGeneralButton(
        //     function: () {
        //       if (_pageController!.page == 2) {
        //         Get.to(
        //           () => const LoginScreen(),
        //           transition: Transition.leftToRight,
        //           duration: const Duration(milliseconds: 400),
        //         );
        //       } else {
        //         _pageController?.nextPage(
        //           curve: Curves.decelerate,
        //           duration: const Duration(milliseconds: 400),
        //         );
        //       }
        //     },
        //     text: _pageController!.hasClients && _pageController!.page! >= 1.5
        //         ? 'Get Start'
        //         : 'Next',
        //   ),
        // ), //CustomGeneralButton
      ],
    );
  }
}
