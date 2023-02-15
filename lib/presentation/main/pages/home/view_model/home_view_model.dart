import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/models/models.dart';
import 'package:tut_app/domain/usecase/home_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/state_render/state_render.dart';
import 'package:tut_app/presentation/common/state_render/state_renderer_imp.dart';



class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final _dataStreamController = BehaviorSubject<HomeViewObject>();
  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  // --  inputs
  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRenderType: StateRenderType.fullScreenLoadingState));
    (await _homeUseCase.execute(null)).fold(
            (failure) => {
          // left -> failure
          inputState.add(ErrorState(
            stateRenderType:StateRenderType.fullScreenErrorState,
            message:  failure.message,))
        }, (home) {
      // right -> data (success)
      // content
      inputHomeData.add(HomeViewObject(
          home.data!.stores,
          home.data!.services,
          home.data!.banners));
      // navigate to main screen
    });
    inputState.add(ContentState());

  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  // -- outputs
  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInput {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutput {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Stores> stores;
  List<Service>? services;
  List<Banners> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}
