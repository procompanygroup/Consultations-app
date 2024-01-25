import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiInterceptor extends Interceptor {

  //Dio dio = Dio();
  // final ApiInterceptor requestRetrier;
  //
  // ApiInterceptor({
  //  required this.dio,
  // });

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // get from shared preferences
    const storage = FlutterSecureStorage();
   var accessToken =await storage.read(key: 'token');

    // options.headers.addAll({
    //   'content-type': 'application/json',
    // });
   options.headers['Authorization'] = 'Bearer $accessToken';
    // get token from the storage
    // if (accessToken != null) {
    //   options.headers.addAll({
    //     'authorization': 'Bearer ${accessToken}',
    //   });
    // }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response,handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if the user is unauthorized.

    if (err.response?.statusCode == 401) {
      // Refresh the user's authentication token.
      //this.accessToken =await storage.read(key: 'token');
     // _retry(err.requestOptions);
      // Retry the request.
      try {
       // handler.resolve(await _retry(err.requestOptions));
      } on DioException catch (e) {
        // If the request fails again, pass the error to the next interceptor in the chain.
        handler.next(e);
      }
      // Return to prevent the next interceptor in the chain from being executed.
      return;
    }
    // Pass the error to the next interceptor in the chain.
    handler.next(err);
  }

  // Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
  //   // Create a new `RequestOptions` object with the same method, path, data, and query parameters as the original request.
  //   // get from shared preferences
  //   var clientToken = this.accessToken;
  //   final options = Options(
  //     method: requestOptions.method,
  //     headers: {
  //       "Authorization": "Bearer ${clientToken}",
  //     },
  //   );
  //
  //   // Retry the request with the new `RequestOptions` object.
  //   return dio.request<dynamic>(requestOptions.path,
  //       data: requestOptions.data,
  //       queryParameters: requestOptions.queryParameters,
  //       options: options);
  // }
}