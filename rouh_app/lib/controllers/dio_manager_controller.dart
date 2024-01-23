import 'package:dio/dio.dart';

import '../constants/global.dart';
import 'interceptor_controller.dart';
class DioManager {
  late final Dio dio;
  // final CustomSharedPreferences _customSharedPreferences =
  // new CustomSharedPreferences();

  DioManager._privateConstructor(){
    var headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    };
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        contentType:'application/json' ,
        responseType: ResponseType.plain,
        followRedirects: true,
        headers: headers,
        validateStatus: (int? status) {
          return status != null;
          // return status != null && status >= 200 && status < 300;
        },
      ),
    );

    dio.interceptors.add(
      ApiInterceptor(),
    );
  }

  static final DioManager _instance = DioManager._privateConstructor();

  factory DioManager() {
    return _instance;
  }



}

