import 'package:cuidapet_mobile/app/core/helpers/constantes.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final LocalStorage _localStorage;
  // final LocalSecureStorage _localSecureStorage;

  @readonly
  UserModel? _userLogged;

  AuthStoreBase({
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
  }) : _localStorage = localStorage;
  // _localSecureStorage = localSecureStorage;

  @action
  Future<void> loadUserLogged() async {
    //usuario logado!!!!!
    final userModelJson = await _localStorage
        .read<String>(Constantes.LOCAL_STORAGE_USER_LOGGED_DATA);
    if (userModelJson != null) {
      _userLogged = UserModel.fromJson(userModelJson);
    } else {
      _userLogged = UserModel.empty();
    }

    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user == null) {
        await logout();
      }
    });
  }

  @action
  Future<void> logout() async {
    await _localStorage.clear();
    // await _localSecureStorage.clear();
    _userLogged = UserModel.empty();
  }
}
