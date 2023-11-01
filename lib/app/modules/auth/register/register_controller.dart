import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/messages.dart';
import 'package:cuidapet_mobile/app/services/user/user_services.dart';
import 'package:mobx/mobx.dart';
part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {
  final UserServices _userServices;
  final AppLogger _log;

  RegisterControllerBase({
    required UserServices userServices,
    required AppLogger log,
  })  : _userServices = userServices,
        _log = log;

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      Loader.show();
      await _userServices.register(email: email, password: password);
      Messages.info(
          'Enviamos um e-mail de confirmcao, por favor olhe sua caixas de e-mail');
      Loader.hide();
    } on UserExistsException {
      Loader.hide();
      Messages.alert("Email já utilizado, por favor escolha outro");
    } catch (e, s) {
      Loader.hide();
      _log.error("Erro ao registrar usuario", e, s);
      Messages.alert("Erro ao registrar usuario");
    }
  }
}
