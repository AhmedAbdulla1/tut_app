import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class CustomView extends StatelessWidget {
  const CustomView({
    Key? key,
    required this.image,
    required this.title,
    required this.subTitle,
  }) : super(key: key);
  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Column(
        children: [
          const SizedBox(
            height: AppSize.s50,
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child:
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: AppSize.s50*2,
          ),
          SvgPicture.asset(
            image,
            height: AppSize.s300,
          ),
        ],
      ),
    );
  }
}
