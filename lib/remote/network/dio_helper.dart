import 'package:dio/dio.dart';
class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://voxtest.dlt-development.net/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };

    return await dio.get(
      url,
      queryParameters: query ,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {

    dio.options.headers = {

      'Authorization':  'Bearer $token',
      'Accept':'application/json',

    };

    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }


  static Future<Response> putData({
    required String url,

    Map<String, dynamic>? query,
    String? token,
  }) async {

    dio.options.headers = {

      'Authorization':  'Bearer $token',
      'Accept':'application/json',
      'method':'put'

    };

    return dio.put(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> deleteData({
    required String url,
    required String token
  }) async {

    dio.options.headers = {

      'Authorization':  'Bearer $token',
      'Accept':'application/json',

    };
    return dio.delete(
      url,

    );
  }
// static Future<Response> postData2({
//   required String url,
//   required List<Map<String, dynamic>> data,
//   Map<String, dynamic>? query,
//   String? token,
// }) async {
//
//   dio.options.headers = {
//
//     'Authorization':  'Bearer $token',
//     'Accept':'application/json',
//
//   };
//
//   return dio.post(
//     url,
//     queryParameters: query,
//     data: data,
//   );
// }


}