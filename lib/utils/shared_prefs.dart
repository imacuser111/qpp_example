import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  // More abstraction
  static const _loginInfo = 'loginInfo';

  static Future<bool> setCounter(String value) =>
      _instance.setString(_loginInfo, value);

  static String? getLoginInfo() => _instance.getString(_loginInfo);

  static removeLoginInfo() => _instance.remove(_loginInfo);
}
