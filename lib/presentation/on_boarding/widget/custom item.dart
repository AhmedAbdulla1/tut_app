import 'package:flutter/material.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            style:Theme.of(context).textTheme.headlineMedium
          ),
        ),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Image.asset(
          image,
          height: 230,
        ),
      ],
    );
  }
}
