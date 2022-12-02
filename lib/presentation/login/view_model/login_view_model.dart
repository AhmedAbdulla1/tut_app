import 'dart:async';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/freezed_data.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController<void> _areInputsValid = StreamController.broadcast();
  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  //input
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areInputsValid.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAreInputsValid => _areInputsValid.sink;

  @override
  login() async {
    // (await _loginUseCase.execute(
    //   LoginUseCaseInput(
    //     loginObject.userName,
    //     loginObject.password,
    //   ),
    // ))
    //     .fold((failure) => {}, (data) => {});
  }

  @override
  setEmail(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(
      userName: userName,
    );
    _areInputsValid.add(null);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
      password: password,
    );
    _areInputsValid.add(null);
  }

//output
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outAreInputsValid =>
      _areInputsValid.stream.map((_) => _areAllInputsValid());

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isUserNameValid(
          loginObject.userName,
        ) &&
        _isPasswordValid(
          loginObject.password,
        );
  }
}

abstract class LoginViewModelInput {
  setEmail(String userName);

  setPassword(String password);

  login();

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputAreInputsValid;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outIsUserNameValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outAreInputsValid;
}
