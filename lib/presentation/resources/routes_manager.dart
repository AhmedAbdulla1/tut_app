import 'package:flutter/material.dart';
import 'package:tut_app/presentation/forget_password/forget_password_view.dart';
import 'package:tut_app/presentation/home/home_view.dart';
import 'package:tut_app/presentation/login/login_view.dart';
import 'package:tut_app/presentation/on_boarding/on_boarding_view.dart';
import 'package:tut_app/presentation/register/register_view.dart';
import 'package:tut_app/presentation/setting/setting_view.dart';
import 'package:tut_app/presentation/splash/splash_view.dart';
import 'package:tut_app/presentation/store_details/store_details_view.dart';

class Routes {
  static const String splashScreen = "/";
  static const String onBoardingScreen = "/onBoarding";
  static const String loginScreen = "/login";
  static const String registerScreen = "/register";
  static const String forgetPasswordScreen = "/forgetPassword";
  static const String mainScreen = "/main";
  static const String storeDetailsScreen = "/storeDetails";
  static const String settingScreen = "/setting";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => OnBoardingView());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LogInView());
      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgetPasswordView());
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.settingScreen:
        return MaterialPageRoute(builder: (_) => SettingView());
      case Routes.storeDetailsScreen:
        return MaterialPageRoute(builder: (_) => StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(''),
        ),
        body: const Center(child: Text('')),
      ),
    );
  }
}
