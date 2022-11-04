import 'package:tut_app/presentation/base/base_view_model.dart';

class OnBoardingViewModel extends BaseViewModel  with OnBoardingViewModelInput,OnBoardingViewModelOutput{
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void goNext() {
    // TODO: implement goNext
  }

  @override
  void goPrevious() {
    // TODO: implement goPrevious
  }

  @override
  void onChangePage(int index) {
    // TODO: implement onChangePage
  }


}

abstract class  OnBoardingViewModelInput{

  void goNext(); //when user clicks right arrow or swipe left
  void goPrevious(); //when user clicks left arrow or swipe right
  void onChangePage(int index);

}

abstract class OnBoardingViewModelOutput{

}