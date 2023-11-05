import 'package:cuidapet_mobile/app/core/exceptions/failure_exception.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_not_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/helpers/constantes.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './user_services.dart';

class ImplUserServices implements UserServices {
  final AppLogger _log;
  final UserRepository _userRepository;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;

  ImplUserServices({
    required AppLogger log,
    required UserRepository userRepository,
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
  })  : _log = log,
        _userRepository = userRepository,
        _localStorage = localStorage,
        _localSecureStorage = localSecureStorage;
  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final userMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);
      if (userMethods.isNotEmpty) {
        throw UserExistsException();
      }
      await _userRepository.register(email: email, password: password);
      final userRegisterCredencial = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userRegisterCredencial.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _log.error("Erro ao criar usuario no firebase", e, s);
      throw FailureException(message: "Erro ao criar usuario");
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final loginMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);
      if (loginMethods.isEmpty) {
        throw UserNotExistsException();
      } else if (loginMethods.contains("password")) {
        final userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        final userVerified = userCredential.user?.emailVerified ?? false;
        if (!userVerified) {
          userCredential.user?.sendEmailVerification();
          throw FailureException(
              message:
                  "E-mail não confirmado, por favor verifique seu e-mail, se não encontrar verifique a caixa de spam");
        }
        final accessToken =
            await _userRepository.login(email: email, password: password);
        await _saveAccessToken(accessToken);
        await _confirmLogin();
        await _getUserData();
      } else {
        throw FailureException(
            message: "Metodo de login incorreto, utilize outro metodo");
      }
    } on FirebaseAuthException catch (e, s) {
      _log.error("E-mail ou senha inválidos FirebaseAuth:${e.code}", e, s);
      throw FailureException(message: "E-mail ou senha inválidos!!!");
    }
  }

  Future<void> _saveAccessToken(String accessToken) => _localStorage
      .write<String>(Constantes.LOCAL_STORAGE_ACCESS_TOKEN_KEY, accessToken);

  Future<void> _confirmLogin() async {
    final confirmLoginModel = await _userRepository.confirmLogin();
    await _saveAccessToken(confirmLoginModel.accessToken);
    await _localSecureStorage.write(
        Constantes.LOCAL_SECURE_STORAGE_REFRESH_TOKEN_KEY,
        confirmLoginModel.refreshToken);
  }

  Future<void> _getUserData() async {
    final userModel = await _userRepository.getUserLogged();
    await _localStorage.write<String>(
        Constantes.LOCAL_STORAGE_USER_LOGGED_DATA, userModel.toJson());
  }
}
