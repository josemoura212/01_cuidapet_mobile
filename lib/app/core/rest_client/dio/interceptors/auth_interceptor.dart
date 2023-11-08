import 'package:cuidapet_mobile/app/core/helpers/constantes.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:dio/dio.dart';

import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthInterceptor extends Interceptor {
  final LocalStorage _localStorage;
  final AuthStore _authStore;

  AuthInterceptor({
    required LocalStorage localStorage,
    required AuthStore authStore,
  })  : _localStorage = localStorage,
        _authStore = authStore;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final authRequired =
        options.extra[Constantes.REST_CLIENT_AUTH_REQUIRED_KEY] ?? false;

    if (authRequired) {
      final accessToken = await _localStorage
          .read<String>(Constantes.LOCAL_STORAGE_ACCESS_TOKEN_KEY);
      if (accessToken == null) {
        _authStore.logout();
        FirebaseAuth.instance.signOut();
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
}
