
import 'package:flutter/material.dart';

enum LanguageType{
  english,
  arabic,
}
const String english='en';
const String arabic='ar';

const String assetPathLocalizations ='assets/translations';
const Locale englishLocale=Locale('en',"US");
const Locale arabicLocale=Locale('ar',"SA");


extension LanguageTypeExtension on LanguageType{

  String getValue(){
    switch(this){
      case LanguageType.english:
        return english;
        break;
      case LanguageType.arabic:
        return arabic;
    }
  }
}