import 'package:cuidapet_mobile/app/core/helpers/constantes.dart';
import 'package:cuidapet_mobile/app/core/helpers/environments.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_client/dio/interceptors/auth_interceptor.dart';
import 'package:cuidapet_mobile/app/core/rest_client/dio/interceptors/auth_refresh_token_interceptor.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client_exception.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client_response.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:dio/dio.dart';

class DioRestClient implements RestClient {
  late final Dio _dio;
  final _defaultOptions = BaseOptions(
    baseUrl: Environments.param(Constantes.ENV_BASE_URL_KEY) ?? "",
    connectTimeout: Duration(
      milliseconds: int.parse(
          Environments.param(Constantes.ENV_REST_CLIENT_CONNECT_TIMEOUT_KEY) ??
              "0"),
    ),
    receiveTimeout: Duration(
      milliseconds: int.parse(
          Environments.param(Constantes.ENV_REST_CLIENT_RECEIVE_TIMEOUT_KEY) ??
              "0"),
    ),
  );

  DioRestClient({
    BaseOptions? baseOptions,
    required LocalStorage localStorage,
    required AppLogger log,
    required AuthStore authStore,
    required LocalSecureStorage localSecureStorage,
  }) {
    _dio = Dio(baseOptions ?? _defaultOptions);
    _dio.interceptors.addAll([
      AuthInterceptor(localStorage: localStorage, authStore: authStore),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
      AuthRefreshTokenInterceptor(
        authStore: authStore,
        localStorage: localStorage,
        localSecureStorage: localSecureStorage,
        restClient: this,
        log: log,
      ),
    ]);
  }

  @override
  RestClient auth() {
    _defaultOptions.extra[Constantes.REST_CLIENT_AUTH_REQUIRED_KEY] = true;
    return this;
  }

  @override
  RestClient unAuth() {
    _defaultOptions.extra[Constantes.REST_CLIENT_AUTH_REQUIRED_KEY] = false;
    return this;
  }

  @override
  Future<RestClientResponse<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioException catch (e) {
      throw _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioException catch (e) {
      throw _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioException catch (e) {
      throw _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter(response);
    } on DioException catch (e) {
      throw _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return _dioResponseConverter(response);
    } on DioException catch (e) {
      throw _throwRestClientException(e);
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(
    String path, {
    required String method,
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers, method: method),
      );

      return _dioResponseConverter(response);
    } on DioException catch (e) {
      throw _throwRestClientException(e);
    }
  }

  Future<RestClientResponse<T>> _dioResponseConverter<T>(
      Response<dynamic> response) async {
    return RestClientResponse(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  Never _throwRestClientException(DioException dioException) {
    final response = dioException.response;
    throw RestClientException(
      error: dioException.error,
      message: response?.statusMessage,
      statusCode: response?.statusCode,
      response: RestClientResponse(
        data: response?.data,
        statusCode: response?.statusCode,
        statusMessage: response?.statusMessage,
      ),
    );
  }
}
