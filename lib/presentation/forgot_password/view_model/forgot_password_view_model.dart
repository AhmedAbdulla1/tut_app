import 'dart:async';
import 'package:tut_app/domain/usecase/forgot_password_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/freezed_data/freezed_data.dart';
import 'package:tut_app/presentation/common/state_render/state_render.dart';
import 'package:tut_app/presentation/common/state_render/state_renderer_imp.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController<void> _areInputsValid = StreamController.broadcast();
  var forgotPasswordObject = ForgotPasswordObject("");
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  StreamController isUserForgotPasswordSuccessfullyStreamController =
      StreamController<bool>();

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  var email = "";

  //input
  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areInputsValid.close();
    isUserForgotPasswordSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // هنا هستدعي المحتوي بدون انتظار لاي شيء لان دا عرض للصفحة فقط لا يعتمد علي اي شيء خارجي
    inputState.add(ContentState());
  }

  @override
  Sink get inputEmail => _userNameStreamController.sink;

  @override
  forgotPassword() async {
    inputState.add(
      LoadingState(
        stateRenderType: StateRenderType.popupLoadingState,
      ),
    );
    (await _forgotPasswordUseCase.execute(
      email,
    ))
        .fold((failure) {
      inputState.add(ErrorState(
        stateRenderType: StateRenderType.popupErrorState,
        message: failure.message,
      ));
    }, (data) {
          print(data);
      inputState.add(
        SuccessState(data),
      );
      isUserForgotPasswordSuccessfullyStreamController.add(true);
    });
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _areInputsValid.add(null);
  }

//output
  @override
  Stream<bool> get outIsEmailValid =>
      _userNameStreamController.stream.map((email) => _isEmailValid(email));

  bool _isEmailValid(String userName) {
    return userName.isNotEmpty;
  }
}

abstract class ForgotPasswordViewModelInput {
  setEmail(String email);

  forgotPassword();

  Sink get inputEmail;
}

abstract class ForgotPasswordViewModelOutput {
  Stream<bool> get outIsEmailValid;
}
