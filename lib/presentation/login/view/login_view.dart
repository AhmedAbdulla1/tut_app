import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/reusable/custom_button.dart';
import 'package:tut_app/presentation/common/reusable/custom_text_form_field.dart';
import 'package:tut_app/presentation/common/state_render/state_renderer_imp.dart';
import 'package:tut_app/presentation/login/view_model/login_view_model.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final _formKey = GlobalKey<FormState>();
  bool isVisible = true;

  _bind() {
    _loginViewModel.start(); //tell view model start your jop
    _emailController.addListener(
      // to list the update value in text form field
      () => _loginViewModel.setEmail(
        _emailController.text,
      ),
    );
    _passwordController.addListener(
      () => _loginViewModel.setPassword(
        _passwordController.text,
      ),
    );
    _loginViewModel.isUserLoginSuccessfullyStreamController.stream
        .listen((isLogin) {
      if (isLogin) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setPressKeyLoginScreen();
          Navigator.of(context).pushReplacementNamed(Routes.mainScreen);
        });
      }
    });
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<StateFlow>(
        stream: _loginViewModel.outputState,
        builder: (context, snapshot) =>
            snapshot.data?.getScreenWidget(
              context,
              _getContent(),
              () {
                _loginViewModel.login();
              },
            ) ??
            _getContent(),
      ),
    );
  }

  Widget _getContent() {
    return SizedBox(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p28),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: AppPadding.p70,
                ),
                Image.asset(
                  ImageAssets.splashLogo,
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                customTextFormField(
                  stream: _loginViewModel.outIsUserNameValid,
                  textEditingController: _emailController,
                  hintText: AppStrings.email,
                  errorText: AppStrings.emailError,
                ),
                const SizedBox(
                  height: AppSize.s8,
                ),
                customPasswordFormField(
                  stream1: _loginViewModel.outIsUserNameValid,
                  stream2: _loginViewModel.outVisibility,
                  textEditingController: _passwordController,
                  onPressed: () {
                    isVisible = !isVisible;
                    _loginViewModel.setVisibility(isVisible);
                  },
                ),
                // StreamBuilder<bool>(
                //   stream: _loginViewModel.outIsPasswordValid,
                //   builder: (context, snapshot) => TextFormField(
                //     keyboardType: TextInputType.visiblePassword,
                //     controller: _passwordController,
                //     decoration: InputDecoration(
                //       hintText: AppStrings.password,
                //       errorText: (snapshot.data ?? true)
                //           ? null
                //           : AppStrings.passwordError,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                customElevatedButton(
                  stream: _loginViewModel.outAreInputsValid,
                  text: AppStrings.login,
                  onPressed: () {
                    _loginViewModel.login();
                  },
                ),
                const SizedBox(
                  height: AppSize.s8,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.forgotPasswordScreen,
                        );
                      },
                      child: Text(
                        AppStrings.forgetPassword,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.registerScreen,
                        );
                      },
                      child: Text(
                        AppStrings.register,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
