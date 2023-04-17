


import 'package:shared_preferences/shared_preferences.dart';


class AppPreferences {
  static late SharedPreferences _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();


  ///On Boarding
 /* ///OnBoarding Getter
  static bool? getOnBoardShow() {
    bool? s = _preferences.getBool(AppKeys.onBoardDone) ?? true;
    return s!;
  }

  ///OnBoarding Setter
  static void setOnBoardShow(bool show){
    _preferences.setBool(AppKeys.onBoardDone, show);
  }
*/



  ///User Email getter
  static String? getToken() {
    String s = _preferences.getString('userToken') ?? '';
    return s!;
  }

  static void saveToken({required String token}) {
    _preferences.setString('userToken', token);
    _preferences.setBool('isUserLogin', true);
  }

  static void clearToken() {
    _preferences.setString('userToken', '');
    _preferences.setBool('isUserLogin', false);
  }
  static bool? getIsUserLogin() {
    bool s = _preferences.getBool('isUserLogin') ?? false;
    return s!;
  }

}
