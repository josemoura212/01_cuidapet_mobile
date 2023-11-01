import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/services/user/impl_user_services.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final ImplUserServices _userServices;
  final AppLogger _log;

  LoginControllerBase({
    required ImplUserServices userServices,
    required AppLogger log,
  })  : _userServices = userServices,
        _log = log;

  Future<void> login({
    required String login,
    required String password,
  }) async {
    print('login: $login');
    // try {
    print('password: $password');
    Loader.show();
    await Future.delayed(const Duration(seconds: 3));
    Loader.hide();
    // await _userServices.authenticate(email: loging, password: password);
    // Messages.info("Logado com sucesso");
    // } catch (e) {
    // _log.error('Erro ao autenticar o usuário', e);
    // Messages.alert("Usuario ou senha invalidos");
    // }
  }
}
