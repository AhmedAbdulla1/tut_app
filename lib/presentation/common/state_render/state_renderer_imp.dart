import 'package:flutter/material.dart';
import 'package:tut_app/app/constant.dart';
import 'package:tut_app/presentation/common/state_render/state_render.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';

abstract class StateFlow {
  String getMessage();

  StateRenderType getStateRenderType();
}

// loading State (popup ,fullscreen)
class LoadingState extends StateFlow {
  final StateRenderType stateRenderType;
  final String message;

  LoadingState({
    required this.stateRenderType,
    this.message = AppStrings.loading,
  });

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => stateRenderType;
}

// error State (popup ,fullscreen)
class ErrorState extends StateFlow {
  final StateRenderType stateRenderType;
  final String message;

  ErrorState({
    required this.stateRenderType,
    required this.message,
  });

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => stateRenderType;
}

//empty state
class EmptyState extends StateFlow {
  final String message;

  EmptyState({
    required this.message,
  });

  @override
  String getMessage() => message;

  @override
  StateRenderType getStateRenderType() => StateRenderType.fullScreenEmptyState;
}
// content state

class ContentState extends StateFlow {
  @override
  String getMessage() => Constant.empty;

  @override
  StateRenderType getStateRenderType() => StateRenderType.contentState;
}

extension StateFlowExtension on StateFlow {
  Widget getScreenWidget(
      BuildContext context, Widget contentScreenWidget, Function retryAction) {
    switch (runtimeType) {
      case LoadingState:
        {
          dismissDialog(context);
          if (getStateRenderType() == StateRenderType.popupLoadingState) {
            // popup show
            showPopup(context, getStateRenderType(), getMessage());
            //return content screen
            return contentScreenWidget;
          } else {
            //return full screen loading state
            return StateRenderer(
              stateRenderType: StateRenderType.fullScreenLoadingState,
              retryAction: () {},
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRenderType() == StateRenderType.popupErrorState) {
            showPopup(context, getStateRenderType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRenderType: StateRenderType.fullScreenErrorState,
              retryAction: () {},
            );
          }
        }
      case EmptyState:
        return StateRenderer(
            stateRenderType: StateRenderType.fullScreenEmptyState,
            retryAction: () {});
      case ContentState:{
        return contentScreenWidget;
      }
      default:
        dismissDialog(context);
        return contentScreenWidget;
    }
  }

  showPopup(
      BuildContext context, StateRenderType stateRenderType, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateRenderType: stateRenderType,
            message: message,
            retryAction: () {})));
  }
  // for check if there dialog message of not
  _isCurrentDialogShowing(BuildContext context)=>
      ModalRoute.of(context)?.isCurrent!=true;
  dismissDialog(BuildContext context) {
    if(_isCurrentDialogShowing(context)){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }
}
