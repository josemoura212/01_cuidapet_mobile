import 'package:cuidapet_mobile/app/modules/auth/register/register_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'register_page.dart';

class RegisterModule extends Module {
  @override
  void binds(i) => i.add((i) => RegisterController.new);

  @override
  void routes(RouteManager r) =>
      r..child('/', child: (context) => const RegisterPage());
}
