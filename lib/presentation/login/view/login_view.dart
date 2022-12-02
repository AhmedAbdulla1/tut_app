import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/login/view_model/login_view_model.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/theme_manager.dart';
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
  final _formKey = GlobalKey<FormState>();

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
    return _getContent();
  }

  Widget _getContent() {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: SingleChildScrollView(
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
                  StreamBuilder<bool>(
                    stream: _loginViewModel.outIsUserNameValid,
                    builder: (context, snapshot) => TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: AppStrings.username,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.usernameError,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s8,
                  ),
                  StreamBuilder<bool>(
                    stream: _loginViewModel.outIsPasswordValid,
                    builder: (context, snapshot) => TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: AppStrings.password,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.passwordError,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s40,
                  ),
                  StreamBuilder(
                      stream: _loginViewModel.outAreInputsValid,
                      builder: (context, snapshot) => SizedBox(
                        height: AppSize.s40,
                        width: double.infinity,
                        child: ElevatedButton(
                                onPressed: (true)
                                    ? () {
                                        _loginViewModel.login();
                                      }
                                    : null,
                                child: const Text(
                                  AppStrings.login,
                                )),
                          )),
                  const SizedBox(
                    height: AppSize.s8,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.forgetPasswordScreen);
                        },
                        child: Text(
                          AppStrings.forgetPassword,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.registerScreen);
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
        ));
  }
}
