import 'package:cuidapet_mobile/app/core/helpers/constantes.dart';
import 'package:dio/dio.dart';

import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorage _localStorage;
  final AppLogger _log;
  AuthInterceptor({
    required LocalStorage localStorage,
    required AppLogger log,
  })  : _localStorage = localStorage,
        _log = log;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authRequired =
        options.extra[Constantes.REST_CLIENT_AUTH_REQUIRED_KEY] ?? false;

    if (authRequired) {
      final accessToken = await _localStorage
          .read<String>(Constantes.LOCAL_STORAGE_ACCESS_TOKEN_KEY);
      if (accessToken == null) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: "Expire token",
            type: DioExceptionType.cancel,
          ),
        );
      }
      options.headers["Authorization"] = accessToken;
    } else {
      options.headers.remove("Authorization");
    }

    handler.next(options);
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   // TODO: implement onResponse
  //   super.onResponse(response, handler);
  // }

  // @override
  // void onError(DioException err, ErrorInterceptorHandler handler) {
  //   // TODO: implement onError
  //   super.onError(err, handler);
  // }
}
