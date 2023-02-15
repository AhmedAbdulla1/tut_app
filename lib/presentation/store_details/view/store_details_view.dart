import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/presentation/common/state_render/state_renderer_imp.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';
import 'package:tut_app/presentation/store_details/view_model/store_view_model.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreViewModel _storeDetailsViewModel = instance<StoreViewModel>();

  void _bind() {
    _storeDetailsViewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _storeDetailsViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.storeDetails,
        ),
      ),
      body: StreamBuilder<StateFlow>(
        stream: _storeDetailsViewModel.outputState,
        builder: (context, snapshot) =>
            snapshot.data?.getScreenWidget(
              context,
              _getContent(),
              () {
                _storeDetailsViewModel.start();
              },
            ) ??
            _getContent(),
      ),
    );
  }

  Widget _getContent() {
    return SingleChildScrollView(
      child: StreamBuilder<StoreViewObject>(
          stream: _storeDetailsViewModel.outputStoreDetailsData,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getImage(snapshot.data!.image),
                  _getSection(AppStrings.details),
                  _getText(snapshot.data!.details),
                  _getSection(AppStrings.services),
                  _getText(snapshot.data!.service),
                  _getSection(AppStrings.about),
                  _getText(snapshot.data!.about),
                ],
              );
            } else {
              return Container();
            }
          }),
    );
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p12,
        right: AppPadding.p12,
        bottom: AppPadding.p2,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }

  Widget _getImage(String image) {
    return Image.network(
      image,
    );
  }

  Widget _getText(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p12,
        right: AppPadding.p12,
        bottom: AppPadding.p2,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
