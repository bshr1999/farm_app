import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init(){
    dio=Dio(
        BaseOptions(
          baseUrl: 'https://walematk.com/api/',
          receiveDataWhenStatusError: true,
        )
    );
  }
  static Future<Response>postData({
    required Map<String,dynamic>headers,
    required String url,
    required Map<String, dynamic> data,
    String? token,
  }){
    dio!.options.headers=headers;
    return dio!.post(
      url,
      data: data,
    );
  }
  static Future<Response>getData({
    required Map<String,dynamic>headers,
    required String url,
  }){
    dio!.options.baseUrl=url;
    dio!.options.headers=headers;
    return dio!.get(
      url,
    );
  }

  static Future<Response>deleteData({
    required Map<String,dynamic>headers,
    required String url,
  }){
    dio!.options.baseUrl=url;
    dio!.options.headers=headers;
    return dio!.delete(
      url,
    );
  }
}