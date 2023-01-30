import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/reusable/custom_text_form_field.dart';
import 'package:tut_app/presentation/common/state_render/state_renderer_imp.dart';
import 'package:tut_app/presentation/forgot_password/view_model/forgot_password_view_model.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgotPasswordViewModel _forgotPasswordViewModel =
      instance<ForgotPasswordViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _forgotPasswordViewModel.start(); //tell view model start your jop
    _emailController.addListener(
      // to list the update value in text form field
      () => _forgotPasswordViewModel.setEmail(
        _emailController.text,
      ),
    );
    _forgotPasswordViewModel
        .isUserForgotPasswordSuccessfullyStreamController.stream
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
    _forgotPasswordViewModel.dispose();
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
        stream: _forgotPasswordViewModel.outputState,
        builder: (context, snapshot) =>
            snapshot.data?.getScreenWidget(
              context,
              _getContent(),
              () {},
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
                    _forgotPasswordViewModel.outIsEmailValid,
                    _emailController,
                    AppStrings.email,
                    AppStrings.emailError
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                StreamBuilder<bool>(
                    stream: _forgotPasswordViewModel.outIsEmailValid,
                    builder: (context, snapshot) => SizedBox(
                          height: AppSize.s40,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _forgotPasswordViewModel.forgotPassword();
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.didnotRecieve,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        _forgotPasswordViewModel.forgotPassword();
                      },
                      child: Text(
                        AppStrings.resend,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
