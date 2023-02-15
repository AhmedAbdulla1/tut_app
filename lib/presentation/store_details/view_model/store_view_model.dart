import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/usecase/store_details_usecase.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/common/state_render/state_render.dart';
import 'package:tut_app/presentation/common/state_render/state_renderer_imp.dart';

class StoreViewModel extends BaseViewModel
    with StoreViewModelInput, StoreViewModelOutput {
  final _dataStreamController = BehaviorSubject<StoreViewObject>();

  final StoreDetailsUseCase _storeDetailsUseCase;

  StoreViewModel(this._storeDetailsUseCase);

  // --  inputs
  @override
  void start() {
    _getStoreDetailsData();
  }

  _getStoreDetailsData() async {
    inputState.add(
        LoadingState(stateRenderType: StateRenderType.fullScreenLoadingState));
    (await _storeDetailsUseCase.execute(null)).fold(
        (failure) => {
              // left -> failure
              inputState.add(
                ErrorState(
                  stateRenderType: StateRenderType.fullScreenErrorState,
                  message: failure.message,
                ),
              )
            }, (storeDetails) {
      inputStoreDetailsData.add(StoreViewObject(
        image: storeDetails.image,
        details: storeDetails.details,
        service: storeDetails.service,
        about: storeDetails.about,
      ));
      inputState.add(ContentState());
    });
  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  // inputs
  @override
  Sink get inputStoreDetailsData => _dataStreamController.sink;

  // -- outputs
  @override
  Stream<StoreViewObject> get outputStoreDetailsData =>
      _dataStreamController.stream.map((data) => data);
}

abstract class StoreViewModelInput {
  Sink get inputStoreDetailsData;
}

abstract class StoreViewModelOutput {
  Stream<StoreViewObject> get outputStoreDetailsData;
}

class StoreViewObject {
  String image;
  String details;
  String service;
  String about;

  StoreViewObject({
    required this.image,
    required this.details,
    required this.service,
    required this.about,
  });
}
