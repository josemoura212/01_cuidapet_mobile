import 'package:cuidapet_mobile/app/modules/auth/login/login_controller.dart';
import 'package:cuidapet_mobile/app/modules/auth/login/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  void binds(i) => i..addLazySingleton(LoginController.new);

  @override
  void routes(RouteManager r) =>
      r..child('/', child: (context) => const LoginPage());
}
