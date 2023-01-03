import 'dart:async';
import 'package:tut_app/domain/usecase/register_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/freezed_data.dart';
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
  final StreamController<void> _areInputsValid = StreamController.broadcast();

  //ToDo change login object to register object
  var loginObject = LoginObject("", "");
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  //input
  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
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
        loginObject.userName,
        loginObject.password,
      ),
    ))
        .fold((failure) => {}, (data) => {});
  }

  @override
  setUsername(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(
      userName: userName,
    );
    _areInputsValid.add(null);
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    loginObject = loginObject.copyWith(
      userName: email,
    );
    _areInputsValid.add(null);
  }

  @override
  setPassword(String password,bool isVisible) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
      password: password,
    );
    _areInputsValid.add(null);
  }

//output

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

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

  bool _areAllInputsValid() {
    return _isUserNameValid(
          loginObject.userName,
        ) &&
        _isPasswordValid(
          loginObject.password,
        ) &&
        _isEmailValid(loginObject.userName);
  }
}

abstract class RegisterViewModelInput {
  setUsername(String userName);

  setEmail(String email);

  setPassword(String password,bool isVisible);

  register();

  Sink get inputUserName;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputAreInputsValid;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outIsUserNameValid;

  Stream<bool> get outIsEmailValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outAreInputsValid;
}
