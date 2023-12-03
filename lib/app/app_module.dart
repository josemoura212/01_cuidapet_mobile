import 'package:cuidapet_mobile/app/modules/address/address_modular.dart';
import 'package:cuidapet_mobile/app/modules/auth/auth_module.dart';
import 'package:cuidapet_mobile/app/modules/core/core_module.dart';
import 'package:cuidapet_mobile/app/modules/home/home_module.dart.dart';
import 'package:cuidapet_mobile/app/modules/schedules/schedules_module.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void routes(RouteManager r) => r
    ..module("/auth/", module: AuthModule())
    ..module("/home/", module: HomeModule())
    ..module("/address/", module: AddressModule())
    ..module("/supplier/", module: SupplierModule())
    ..module("/schedules/", module: SchedulesModule());

  @override
  List<Module> get imports => [
        CoreModule(),
      ];
}
