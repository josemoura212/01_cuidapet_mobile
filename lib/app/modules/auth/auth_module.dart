import 'package:cuidapet_mobile/app/modules/auth/home/auth_home_page.dart';
import 'package:cuidapet_mobile/app/modules/auth/login/login_module.dart';
import 'package:cuidapet_mobile/app/modules/auth/register/register_module.dart';
import 'package:cuidapet_mobile/app/modules/core/auth/auth_store.dart';
import 'package:cuidapet_mobile/app/repositories/social/social_repository_impl.dart';
import 'package:cuidapet_mobile/app/repositories/social/social_repository.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository_impl.dart';
import 'package:cuidapet_mobile/app/repositories/user/user_repository.dart';
import 'package:cuidapet_mobile/app/services/user/user_services_impl.dart';
import 'package:cuidapet_mobile/app/services/user/user_services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  void binds(i) => i
    ..addLazySingleton<SocialRepository>(SocialRepositoryImpl.new)
    ..addLazySingleton<UserRepository>(UserRepositoryImpl.new)
    ..addLazySingleton<UserServices>(UserServicesImpl.new);

  @override
  void routes(RouteManager r) => r
    ..child(
      "/",
      child: (context) => AuthHomePage(
        authStore: Modular.get<AuthStore>(),
      ),
      // children: [
      //   ModuleRoute("/login/", module: LoginModule()),
      //   ModuleRoute("/register/", module: RegisterModule()),
      // ],
    )
    ..module("/login/", module: LoginModule())
    ..module("/register/", module: RegisterModule());
}
