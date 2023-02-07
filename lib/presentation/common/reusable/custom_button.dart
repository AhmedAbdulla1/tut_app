import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

Widget customElevatedButton({
required  Stream<bool> stream,
 required VoidCallback onPressed,
  required String text,
}) {
  return StreamBuilder<bool>(
    stream: stream,
    builder: (context, snapshot) => SizedBox(
      height: AppSize.s40,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: (snapshot.data ?? false) ? onPressed : null,
          child:Text(
           text,
          )),
    ),
  );
}
