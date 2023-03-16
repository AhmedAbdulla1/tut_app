import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/forgot_password/view/forgot_password_view.dart';
import 'package:tut_app/presentation/login/view/login_view.dart';
import 'package:tut_app/presentation/main/main_view.dart';
import 'package:tut_app/presentation/main/pages/setting/setting_view.dart';
import 'package:tut_app/presentation/on_boarding/view/on_boarding_view.dart';
import 'package:tut_app/presentation/register/view/register_view.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/splash/splash_view.dart';
import 'package:tut_app/presentation/store_details/view/store_details_view.dart';

class Routes {
  static const String splashScreen = "/";
  static const String onBoardingScreen = "/onBoarding";
  static const String loginScreen = "/login";
  static const String registerScreen = "/register";
  static const String forgotPasswordScreen = "/forgetPassword";
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
        return MaterialPageRoute(builder: (_) {
          initOnBoardingModule();
          return const OnBoardingView();
        });
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) {
            initLoginModule();
            return const LogInView();
          },
        );
      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) {
            initRegisterModule();
            return const RegisterView();
          },
        );
      case Routes.forgotPasswordScreen:
        return MaterialPageRoute(
          builder: (_) {
            initForgotPasswordModule();
            return const ForgotPasswordView();
          },
        );
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) {
          initHomeModule();
          return const MainView();
        });
      case Routes.settingScreen:
        return MaterialPageRoute(builder: (_) => const SettingView());
      case Routes.storeDetailsScreen:
        return MaterialPageRoute(builder: (_) {
          initStoreDetailsModule();
          return const StoreDetailsView();});
      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title:  Text(
            AppStrings.noRouteFound.tr(),
          ),
        ),
        body:  Center(
          child: Text(
            AppStrings.noRouteFound.tr(),
          ),
        ),
      ),
    );
  }
}
