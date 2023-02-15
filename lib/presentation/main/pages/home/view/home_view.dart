import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/di.dart';
import 'package:tut_app/domain/models/models.dart';
import 'package:tut_app/presentation/common/state_render/state_renderer_imp.dart';
import 'package:tut_app/presentation/main/pages/home/view_model/home_view_model.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manager.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel _homeViewModel = instance<HomeViewModel>();

  _bind() {
    _homeViewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StateFlow>(
      stream: _homeViewModel.outputState,
      builder: (context, snapshot) =>
          snapshot.data?.getScreenWidget(
            context,
            _getContent(),
            () {
              _homeViewModel.start();
            },
          ) ??
          _getContent(),
    );
  }

  Widget _getContent() {
    return SingleChildScrollView(
      child: StreamBuilder<HomeViewObject>(
          stream: _homeViewModel.outputHomeData,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getBannerWidgets(snapshot.data?.banners),
                _getSection(AppStrings.services),
                _getServicesWidgets(snapshot.data?.services),
                _getSection(AppStrings.stores),
                _getStoresWidgets(snapshot.data?.stores),
              ],
            );
          }),
    );
  }

  Widget _getBannerWidgets(List<Banners>? banners) {
    if (banners != null) {
      return CarouselSlider(
          items: banners
              .map((banner) => SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: AppSize.s1_5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          side: BorderSide(
                              color: ColorManager.primary, width: AppSize.s1)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: Image.network(banner.image!, fit: BoxFit.cover),
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
              height: AppSize.s190,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true));
    } else {
      return Container();
    }
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

  Widget _getServicesWidgets(List<Service>? service) {
    if (service != null) {
      return SizedBox(
        height: AppSize.s140,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: service
              .map((service) => SizedBox(
                    height: AppSize.s140,
                    child: Card(
                      elevation: AppSize.s1_5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        side: BorderSide(
                            color: ColorManager.primary, width: AppSize.s1),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppSize.s12,
                            ),
                            child: Image.network(
                              service.image,
                              fit: BoxFit.cover,
                              width: AppSize.s100,
                              height: AppSize.s100,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              service.title,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStoresWidgets(List<Stores>? stores) {
    if (stores != null) {
      return Flex(
        direction: Axis.vertical,
        children: [
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: AppSize.s8,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            children:stores
                .map(
                  (stores) => InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed(Routes.storeDetailsScreen);
                    },
                child: Card(
                  elevation: AppSize.s4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    side: BorderSide(
                        color: ColorManager.primary, width: AppSize.s1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppSize.s12,
                    ),
                    child: Image.network(
                      stores.image,
                      fit: BoxFit.cover,

                    ),
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
