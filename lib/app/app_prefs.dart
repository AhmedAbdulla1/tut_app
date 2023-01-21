import 'package:shared_preferences/shared_preferences.dart' ;
import 'package:tut_app/presentation/resources/language_manager.dart';

const String prefsKeyLang = "PrefsKeyLang";
const String pressKeyOnBoardingScreen ='PressKeyOnBoardingScreen';
const String pressKeyLoginScreen ='PressKeyLoginScreen';
class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);
    // ignore: unnecessary_null_comparison
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }
  // onBoarding
  Future<void> setPressKeyOnBoardingScreen() async {
    _sharedPreferences.setBool(pressKeyOnBoardingScreen, true);

  }
  Future<bool> isPressKeyOnBoardingScreen() async {
   return _sharedPreferences.getBool(pressKeyOnBoardingScreen)?? false;

  }

  //login
  Future<void> setPressKeyLoginScreen()async{
    _sharedPreferences.setBool(pressKeyLoginScreen, true);
  }
  Future<bool> isPressKeyLoginScreen()async{
    return _sharedPreferences.getBool(pressKeyLoginScreen) ?? false;
  }

}
