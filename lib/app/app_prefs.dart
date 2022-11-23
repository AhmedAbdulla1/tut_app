import 'package:shared_preferences/shared_preferences.dart' ;
import 'package:tut_app/presentation/resources/language_manager.dart';

const String prefsKeyLang = "PrefsKeyLang";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }
}
