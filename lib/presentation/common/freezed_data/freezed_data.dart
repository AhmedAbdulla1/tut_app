
import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data.freezed.dart';

@freezed
class LoginObject with _$LoginObject{
  factory LoginObject(String email,String password)=_LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject{
  factory RegisterObject(String userName,String email,String password,String phone)=_RegisterObject;
}