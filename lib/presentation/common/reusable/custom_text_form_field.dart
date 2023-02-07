import 'package:flutter/material.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';

Widget customTextFormField({
  required Stream<bool> stream,
  required TextEditingController textEditingController,
  TextInputType textInputType = TextInputType.emailAddress,
  required String hintText,
  required String errorText,
}) {
  return StreamBuilder<bool>(
    stream: stream,
    builder: (context, snapshot) => TextFormField(
      keyboardType: textInputType,
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        errorText: (snapshot.data ?? true) ? null : errorText,
      ),
    ),
  );
}

Widget customPasswordFormField({
required  Stream<bool> stream1,
required  Stream<bool> stream2,
required  TextEditingController textEditingController,
  required VoidCallback onPressed,
}) {


  return StreamBuilder2<bool,bool>(
    streams: StreamTuple2(stream1,stream2),
    builder: (context, snapshot) => TextFormField(
      keyboardType: TextInputType.visiblePassword,
      controller: textEditingController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(
            !(snapshot.snapshot2.data?? true ) ? Icons.visibility : Icons.visibility_off,
          ),
        ),
        hintText: AppStrings.password,
        errorText: (snapshot.snapshot1.data ?? true) ? null : AppStrings.passwordError,
      ),
      obscureText: snapshot.snapshot2.data??true,
    ),
  );
}
