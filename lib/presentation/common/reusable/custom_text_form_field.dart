import 'package:flutter/material.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';

Widget customTextFormField(
  Stream<bool> stream,
  TextEditingController textEditingController,
  String hintText,
  String errorText,
) {
  return StreamBuilder<bool>(
    stream: stream,
    builder: (context, snapshot) => TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: (snapshot.data ?? true) ? null : errorText,
      ),
    ),
  );
}
Widget customPasswordFormField(
    Stream<bool> stream1,
    Stream<bool> stream2,
    TextEditingController textEditingController,
    Function() onPressed,
    bool isVisible,
    ){
  return StreamBuilder2<bool, bool>(
    streams: StreamTuple2(
     stream1,
      stream2,
    ),
    builder: (context, snapshot) => TextFormField(
      keyboardType: TextInputType.visiblePassword,
      controller: textEditingController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(
            !isVisible ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        hintText: AppStrings.password,
        errorText: (snapshot.snapshot1.data ?? true)
            ? null
            : AppStrings.passwordError,
      ),
      obscureText: isVisible,
    ),
  );
}