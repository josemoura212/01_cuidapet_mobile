import 'package:cuidapet_mobile/app/core/exceptions/failure_exception.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './user_services.dart';

class ImplUserServices implements UserServices {
  final AppLogger _log;
  final UserRepository _userRepository;

  ImplUserServices(
      {required AppLogger log, required UserRepository userRepository})
      : _log = log,
        _userRepository = userRepository;
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
}
