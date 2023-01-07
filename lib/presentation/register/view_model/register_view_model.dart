import 'dart:async';
import 'package:tut_app/domain/usecase/register_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/freezed_data/freezed_data.dart';
import 'package:tut_app/presentation/common/state_render/state_render.dart';
import 'package:tut_app/presentation/common/state_render/state_renderer_imp.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInput, RegisterViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _emailStreamController =
      StreamController.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _phoneStreamController =
      StreamController<String>.broadcast();
  final StreamController _visibilityStreamController =
      StreamController<String>.broadcast();
  final StreamController<void> _areInputsValid = StreamController.broadcast();

  //ToDo change login object to register object
  var registerObject = RegisterObject("", "", "", "");
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  //input
  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _phoneStreamController.close();
    _areInputsValid.close();
  }

  @override
  void start() {
    // هنا هستدعي المحتوي بدون انتظار لاي شيء لان دا عرض للصفحة فقط لا يعتمد علي اي شيء خارجي
    inputState.add(ContentState());
  }

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputPhone => _phoneStreamController.sink;

  @override
  Sink get inputVisibility => _visibilityStreamController.sink;

  @override
  Sink get inputAreInputsValid => _areInputsValid.sink;

  @override
  register() async {
    inputState.add(
      LoadingState(
        stateRenderType: StateRenderType.popupLoadingState,
      ),
    );
    (await _registerUseCase.execute(
      RegisterUseCaseInput(
        userName: registerObject.userName,
        email: registerObject.email,
        password: registerObject.password,
        phone: registerObject.phone,
      ),
    ))
        .fold((failure) => {}, (data) => {});
  }

  @override
  setUsername(String userName) {
    inputUserName.add(userName);
    registerObject = registerObject.copyWith(
      userName: userName,
    );
    _areInputsValid.add(null);
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    registerObject = registerObject.copyWith(
      email: email,
    );
    _areInputsValid.add(null);
  }

  @override
  setPhone(String phone) {
    inputPhone.add(phone);
    registerObject = registerObject.copyWith(
      phone: phone,
    );
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    registerObject = registerObject.copyWith(
      password: password,
    );
    _areInputsValid.add(null);
  }

  @override
  setVisibility(bool isVisible) {
    inputVisibility.add(isVisible ? "yes" : "no");
  }

//output

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outIsPhoneValid => _phoneStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outVisibility => _visibilityStreamController.stream
      .map((visibility) => isVisibility(visibility));

  @override
  Stream<bool> get outAreInputsValid =>
      _areInputsValid.stream.map((_) => _areAllInputsValid());

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isPhoneValid(String phone) {
    return phone.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isUserNameValid(
          registerObject.userName,
        ) &&
        _isPasswordValid(
          registerObject.password,
        ) &&
        _isEmailValid(
          registerObject.email,
        ) &&
        _isPhoneValid(
          registerObject.phone,
        );
  }

  bool isVisibility(visibility) {
    if (visibility == 'yes') {
      return true;
    }
    return false;
  }
}

abstract class RegisterViewModelInput {
  setUsername(String userName);

  setEmail(String email);

  setPassword(String password);

  setVisibility(bool isVisible);

  setPhone(String phone);

  register();

  Sink get inputUserName;

  Sink get inputEmail;

  Sink get inputPhone;

  Sink get inputPassword;

  Sink get inputVisibility;

  Sink get inputAreInputsValid;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outIsUserNameValid;

  Stream<bool> get outIsEmailValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outIsPhoneValid;

  Stream<bool> get outVisibility;

  Stream<bool> get outAreInputsValid;
}
