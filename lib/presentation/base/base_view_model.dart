abstract class  BaseViewModel extends BaseViewModelInput with BaseViewModelOutput {
  // shared variables and function that will be used through any view model.
}

abstract  class BaseViewModelInput {
  void start(); // start view model job
  void dispose();
}

abstract class  BaseViewModelOutput{
  //
}

