import 'dart:async';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/freezed_data/freezed_data.dart';
import 'package:tut_app/presentation/common/state_render/state_render.dart';
import 'package:tut_app/presentation/common/state_render/state_renderer_imp.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInput, LoginViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController<void> _areInputsValid = StreamController.broadcast();
  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;
  StreamController isUserLoginSuccessfullyStreamController =
      StreamController<bool>();

  LoginViewModel(this._loginUseCase);

  //input
  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areInputsValid.close();
    isUserLoginSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // هنا هستدعي المحتوي بدون انتظار لاي شيء لان دا عرض للصفحة فقط لا يعتمد علي اي شيء خارجي
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputAreInputsValid => _areInputsValid.sink;

  @override
  login() async {
    inputState.add(
      LoadingState(
        stateRenderType: StateRenderType.popupLoadingState,
      ),
    );
    (await _loginUseCase.execute(
      LoginUseCaseInput(
        loginObject.email,
        loginObject.password,
      ),
    ))
        .fold((failure) {
      inputState.add(ErrorState(
        stateRenderType: StateRenderType.popupErrorState,
        message: failure.message,
      ));
    }, (data) {
      inputState.add(
        ContentState(),
      );
      isUserLoginSuccessfullyStreamController.add(true);
    });
  }

  @override
  setEmail(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(
      email: userName,
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
          loginObject.email,
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
