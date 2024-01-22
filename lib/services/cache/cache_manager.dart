import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {

  static SharedPreferences? _pref;

  static Future<void> initAuth(Function(SharedPreferences) onComplete) async {
    _pref = await SharedPreferences.getInstance();
    onComplete(_pref!);
  }


  static String get token => _getFromCache<String>(CacheKeys.token.name);
  static String get userName => _getFromCache<String>(CacheKeys.userName.name);
  static String get loginEmail => _getFromCache<String>(CacheKeys.loginEmail.name);

  static Future<bool> setToken(String tokenValue) async => await _saveToCache(CacheKeys.token.name, tokenValue);
  static Future<bool> setUserName(String value) async => await _saveToCache(CacheKeys.userName.name, value);
  static Future<bool> setLoginEmail(String value) async => await _saveToCache(CacheKeys.loginEmail.name, value);

  static Future<bool> removeToken() async => _remove(CacheKeys.token.name);
  static Future<bool> removeUserName() async => _remove(CacheKeys.userName.name);
  static Future<bool> removeLoginUserName() async => _remove(CacheKeys.loginEmail.name);

  static Future<bool> _remove(String key) async {
    if(_pref == null) {
      return false;
    }
    if(!_pref!.containsKey(key)) {
      return false;
    }
    return await _pref!.remove(key);
  }

  static dynamic _getFromCache<T>(String key) {
    print("$T ${key} getting type: int -> ${T == int} | bool -> ${T == bool} | string -> ${T == String}");
    if(_pref == null) return '';
    if(T == int) {
      return  _pref!.getInt(key) ?? 0;
    }else if(T == bool) {
      return  _pref!.getBool(key) ?? false;
    }
    return  _pref!.getString(key) ?? '';
  }

  static Future<bool> _saveToCache(String key, dynamic value) async {
    print("${value.runtimeType} ${key} _saveToCache type: int -> ${value is int} | bool -> ${value is bool} | string -> ${value is String}");

    if(_pref == null || value == null) return false;
    if(value is bool) {
      return await _pref!.setBool(key, value);
    }else if(value is int) {
      return await _pref!.setInt(key, value);
    }
    return await _pref!.setString(key, value);
  }

}

enum CacheKeys {
  token,
  userName,
  loginEmail
}