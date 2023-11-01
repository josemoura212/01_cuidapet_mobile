import 'package:cuidapet_mobile/app/core/exceptions/failure_exception.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client_exception.dart';
import 'package:dio/dio.dart';

import './user_repository.dart';

class ImplUserRepository implements UserRepository {
  final RestClient _restClient;
  final AppLogger _log;

  ImplUserRepository({required RestClient restClient, required AppLogger log})
      : _restClient = restClient,
        _log = log;

  @override
  Future<void> register(
      {required String email, required String password}) async {
    try {
      final dio = Dio();
      await dio.post("http://localhost:8080/auth/register",
          data: {"email": email, "password": password});
      // await _restClient
      //     .post("/auth/register", data: {"email": email, "password": password});
    } on RestClientException catch (e, s) {
      if (e.statusCode == 400 &&
          e.response.data["message"].contains("Usuario já cadastrado")) {
        _log.error(e.error, e, s);
        throw UserExistsException();
      }
      _log.error("Erro ao cadastrar usuario", e, s);
      throw FailureException(message: "Erro ao registrar usuario");
    }
  }
}
