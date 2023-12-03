import 'package:cuidapet_mobile/app/core/exceptions/failure_exception.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_not_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/life_cycle/controller_life_cycle.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/messages.dart';
import 'package:cuidapet_mobile/app/models/social_login_type_enum.dart';
import 'package:cuidapet_mobile/app/services/user/user_services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store, ControllerLifeCycle {
  final UserServices _userServices;
  final AppLogger _log;

  LoginControllerBase({
    required UserServices userServices,
    required AppLogger log,
  })  : _userServices = userServices,
        _log = log;

  Future<void> login({
    required String login,
    required String password,
  }) async {
    try {
      Loader.show();
      await _userServices.login(email: login, password: password);
      Loader.hide();
      Modular.to.navigate("/auth/");
    } on FailureException catch (e, s) {
      Loader.hide();
      final errorMessage = e.message ?? "Erro ao realizar login";
      _log.error(errorMessage, e, s);
      Messages.alert(errorMessage);
    } on UserNotExistsException {
      Loader.hide();
      const errorMessage = "Usuário não cadastrado";
      _log.error(errorMessage);
      Messages.alert(errorMessage);
    }
  }

  Future<void> socialLogin(SocialLoginType socialLoginType) async {
    try {
      Loader.show();
      await _userServices.socialLogin(socialLoginType);
      Loader.hide();
      Modular.to.navigate("/auth/");
    } on FailureException catch (e, s) {
      Loader.hide();
      _log.error("Erro ao realizar login", e, s);
      Messages.alert(e.message ?? "Erro ao realizar login");
    }
  }
}
