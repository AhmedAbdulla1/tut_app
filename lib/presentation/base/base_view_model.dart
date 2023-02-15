import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:tut_app/presentation/common/state_render/state_renderer_imp.dart';

abstract class  BaseViewModel extends BaseViewModelInput with BaseViewModelOutput {
  // shared variables and function that will be used through any view model.
  final StreamController _inputStreamController = BehaviorSubject<StateFlow>();
  @override
  void dispose() {
    _inputStreamController.close();
  }
  @override
  Sink get inputState =>_inputStreamController.sink;
  @override
  Stream<StateFlow> get outputState => _inputStreamController.stream.map((flowState) => flowState);
}
abstract  class BaseViewModelInput {
  void start(); // start view model job
  void dispose();
  Sink get inputState;
}

abstract class  BaseViewModelOutput{
  //
  Stream<StateFlow> get outputState;
}

