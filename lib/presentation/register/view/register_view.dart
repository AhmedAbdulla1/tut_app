import 'dart:io';

import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/reusable/custom_button.dart';
import 'package:tut_app/presentation/common/reusable/custom_text_form_field.dart';
import 'package:tut_app/presentation/common/state_render/state_renderer_imp.dart';
import 'package:tut_app/presentation/register/view_model/register_view_model.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/font_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/style_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _registerViewModel = instance<RegisterViewModel>();
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final countryPicker = const FlCountryCodePicker();
  CountryCode countryCode = const CountryCode(
    name: 'egypt',
    code: 'EG',
    dialCode: "+20",
  );
  bool isVisible = true;

  _bind() {
    _registerViewModel.start(); //tell view model start your jop
    _registerViewModel.setCountryCode(countryCode.flagImage);
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
      // to list the update value in text form field
      () => _registerViewModel.setPassword(
        _passwordController.text,
      ),
    );
    _phoneController.addListener(
      () => _registerViewModel.setPhone(
        _phoneController.text,
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
                Container(

                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  width: 200,
                  height:200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: StreamBuilder<File>(
                    stream: _registerViewModel.outputProfilePicture,
                    builder: (context, snapshot) {
                      return _imagePicketByUser(snapshot.data);
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                //text form field for userName
                customTextFormField(
                  stream: _registerViewModel.outIsUserNameValid,
                  textEditingController: _usernameController,
                  textInputType: TextInputType.name,
                  hintText: AppStrings.username,
                  errorText: AppStrings.usernameError,
                ),
                const SizedBox(
                  height: AppSize.s8,
                ),
                //country code and  text form field for phone number
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () async {
                          final code = await countryPicker.showPicker(
                              context: context,
                              initialSelectedLocale: countryCode.code);
                          countryCode = code!;
                          _registerViewModel.setCountryCode(code.flagImage);
                        },
                        child: StreamBuilder<Widget>(
                          stream: _registerViewModel.outIsCountryCode,
                          builder: (context, snapshot) => Container(
                            clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  10.0,
                                ),
                              ),
                            ),
                            child: snapshot.data ?? countryCode.flagImage,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: customTextFormField(
                        stream: _registerViewModel.outIsPhoneValid,
                        textEditingController: _phoneController,
                        textInputType: TextInputType.phone,
                        hintText: AppStrings.phone,
                        errorText: AppStrings.phoneError,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s8,
                ),
                //text form field for email
                customTextFormField(
                  stream: _registerViewModel.outIsEmailValid,
                  textEditingController: _emailController,
                  hintText: AppStrings.email,
                  errorText: AppStrings.emailError,
                ),
                const SizedBox(
                  height: AppSize.s8,
                ),
                //text form field for password
                customPasswordFormField(
                    stream1: _registerViewModel.outIsPasswordValid,
                    stream2: _registerViewModel.outVisibility,
                    textEditingController: _passwordController,
                    onPressed: () {
                      isVisible = !isVisible;
                      _registerViewModel.setVisibility(isVisible);
                    }),
                const SizedBox(
                  height: AppSize.s18,
                ),
                // for upload profile picture
                GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(
                      AppPadding.p8,
                    ),
                    height: AppSize.s50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          AppSize.s8,
                        ),
                      ),
                      border: Border.all(
                        width: 1.5,
                        color: ColorManager.grey,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppStrings.profilePicture,
                            style: getRegularStyle(
                              color: ColorManager.primary,
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          ImageAssets.photoCameraIc,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                // انا عامل ستريم عشان الحالة بتتغير علي حسب البيانات الموجوده في الخانات
                customElevatedButton(
                  stream: _registerViewModel.outAreInputsValid,
                  text: AppStrings.signup,
                  onPressed: () {
                    _registerViewModel.register();
                  },
                ),
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

  _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title: const Text(AppStrings.photoGallery),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text(AppStrings.photoCamera),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      },
    );
  }

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _registerViewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _registerViewModel.setProfilePicture(File(image?.path ?? ""));
  }
  Widget _imagePicketByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      // return image
      return Image.file(image);
    } else {
      return Image.asset(
        ImageAssets.splashLogo,
      );
    }
  }
}
