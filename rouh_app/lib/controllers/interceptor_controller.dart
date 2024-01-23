import 'package:dio/dio.dart';

import '../constants/global.dart';

class ApiInterceptor extends Interceptor {

  // final ApiInterceptor requestRetrier;
  //
  // ApiInterceptor({
  //  required this.requestRetrier,
  // });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // get from shared preferences
    var clientToken = token;
    options.headers.addAll({
      "Content-Type": "application/json",
    });
    // get token from the storage
    if (clientToken != null) {
      options.headers.addAll({
        "Authorization": "Bearer ${clientToken}",
      });
    }
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
      //await refreshToken();
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
  //   var clientToken = token;
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