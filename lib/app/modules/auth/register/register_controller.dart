import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
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

  Future<void> register(
      {required String email, required String password}) async {
    Loader.show();
    await Future.delayed(const Duration(seconds: 2));
    Loader.hide();
  }
}
