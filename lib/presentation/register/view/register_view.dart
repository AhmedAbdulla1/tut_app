import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/state_render/state_renderer_imp.dart';
import 'package:tut_app/presentation/register/view_model/register_view_model.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = true;

  _bind() {
    _registerViewModel.start(); //tell view model start your jop

    _usernameController.addListener(
      // to list the update value in text form field
      () => _registerViewModel.setUsername(
        _usernameController.text,
      ),
    );
    _emailController.addListener(
      // to list the update value in text form field
      () => _registerViewModel.setEmail(
        _emailController.text,
      ),
    );
    _passwordController.addListener(
      () => _registerViewModel.setPassword(
        _passwordController.text,
        _isVisible
      ),
    );
  }

  @override
  void dispose() {
    _registerViewModel.dispose();
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
        stream: _registerViewModel.outputState,
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
                //text form field for userName
                StreamBuilder<bool>(
                  stream: _registerViewModel.outIsUserNameValid,
                  builder: (context, snapshot) => TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _usernameController,
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
                //text form field for email
                StreamBuilder<bool>(
                  stream: _registerViewModel.outIsEmailValid,
                  builder: (context, snapshot) => TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: AppStrings.email,
                      errorText: (snapshot.data ?? true)
                          ? null
                          : AppStrings.usernameError,
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s8,
                ),
                //text form field for password
                StreamBuilder<bool>(
                  stream: _registerViewModel.outIsPasswordValid,
                  builder: (context, snapshot) => TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {_isVisible=!_isVisible;},
                        icon: const Icon(Icons.remove_red_eye_rounded,),
                      ),
                      hintText: AppStrings.password,
                      errorText: (snapshot.data ?? true)
                          ? null
                          : AppStrings.passwordError,
                    ),
                    obscureText: _isVisible,
                  ),
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                // انا عامل ستريم عشان الحالة بتتغير علي حسب البيانات الموجوده في الخانات
                StreamBuilder<bool>(
                    stream: _registerViewModel.outAreInputsValid,
                    builder: (context, snapshot) => SizedBox(
                          height: AppSize.s40,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _registerViewModel.register();
                                    }
                                  : null,
                              child: const Text(
                                AppStrings.signup,
                              )),
                        )),
                const SizedBox(
                  height: AppSize.s8,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginScreen);
                  },
                  child: Text(
                    AppStrings.reLogin,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
