import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/forget_password/forget_password_view.dart';
import 'package:tut_app/presentation/home/home_view.dart';
import 'package:tut_app/presentation/login/view/login_view.dart';
import 'package:tut_app/presentation/on_boarding/view/on_boarding_view.dart';
import 'package:tut_app/presentation/register/register_view.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
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
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());
      case Routes.loginScreen:
        // initLoginModule();
        return MaterialPageRoute(builder: (_) => const LogInView());
      case Routes.registerScreen:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.settingScreen:
        return MaterialPageRoute(builder: (_) => const SettingView());
      case Routes.storeDetailsScreen:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.noRouteFound,
          ),
        ),
        body: const Center(
          child: Text(
            AppStrings.noRouteFound,
          ),
        ),
      ),
    );
  }
}
