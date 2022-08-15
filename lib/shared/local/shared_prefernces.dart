import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPreferences;

  static init()async{
    sharedPreferences=await SharedPreferences.getInstance();
  }

  static Future<void>setBool({
    required String key,
    required bool value,
  }){
    return sharedPreferences!.setBool(key, value);
  }

  static bool? getBool({
    required String key,
  }){
    return sharedPreferences!.getBool(key);
  }

  static String? getStringData({
    required String key,
  }){
    return sharedPreferences!.getString(key);
  }

  static Future<bool> setStringData({
    required String key,
    required dynamic value,
  })async{
    return await  sharedPreferences!.setString(key, value);
  }
  static Future<bool> removeData({
    required String key,
  }) async
  {
    return await sharedPreferences!.remove(key);
  }
}