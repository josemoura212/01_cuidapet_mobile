import 'package:cuidapet_mobile/app/modules/auth/home/auth_home_page.dart';
import 'package:cuidapet_mobile/app/modules/auth/login/login_module.dart';
import 'package:cuidapet_mobile/app/modules/auth/register/register_module.dart';
import 'package:cuidapet_mobile/app/repositories/social/impl_social_repository.dart';
import 'package:cuidapet_mobile/app/repositories/social/social_repository.dart';
import 'package:cuidapet_mobile/app/repositories/user/impl_user_repository.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:cuidapet_mobile/app/services/user/impl_user_services.dart';
import 'package:cuidapet_mobile/app/services/user/user_services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<SocialRepository>(
          (i) => ImplSocialRepository(),
        ),
        Bind.lazySingleton<UserRepository>(
            (i) => ImplUserRepository(log: i(), restClient: i())),
        Bind.lazySingleton<UserServices>((i) => ImplUserServices(
              log: i(),
              userRepository: i(),
              localStorage: i(),
              localSecureStorage: i(),
              socialRepository: i(),
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (context, args) => AuthHomePage(authStore: Modular.get())),
        ModuleRoute("/login/", module: LoginModule()),
        ModuleRoute("/register/", module: RegisterModule()),
      ];
}
