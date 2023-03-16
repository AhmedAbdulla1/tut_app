import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:tut_app/domain/models/models.dart';
import 'package:tut_app/presentation/base/base_view_model.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInput, OnBoardingViewModelOutput {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onChangePage(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // privat input function

  void _postDataToView() {
    _streamController.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }

  List<SliderObject> _getSliderData() => [
        SliderObject(
          AppStrings.onBoardingTitle1.tr(),
          AppStrings.onBoardingSubTitle1.tr(),
          ImageAssets.onBoardingLogo1,
        ),
        SliderObject(
          AppStrings.onBoardingTitle2.tr(),
          AppStrings.onBoardingSubTitle2.tr(),
          ImageAssets.onBoardingLogo2,
        ),
        SliderObject(
          AppStrings.onBoardingTitle3.tr(),
          AppStrings.onBoardingSubTitle3.tr(),
          ImageAssets.onBoardingLogo3,
        ),
        SliderObject(
          AppStrings.onBoardingTitle4.tr(),
          AppStrings.onBoardingSubTitle4.tr(),
          ImageAssets.onBoardingLogo4,
        ),
      ];
}

abstract class OnBoardingViewModelInput {
  int goNext(); //when user clicks right arrow or swipe left
  int goPrevious(); //when user clicks left arrow or swipe right
  void onChangePage(int index);

// Stream controller input
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutput {
  // stream controller output
  Stream<SliderViewObject> get outputSliderViewObject;
}
