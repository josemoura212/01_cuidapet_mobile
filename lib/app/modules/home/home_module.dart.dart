import 'package:cuidapet_mobile/app/modules/core/supplier/supplier_core_module.dart';
import 'package:cuidapet_mobile/app/modules/home/home_controller.dart';
import 'package:cuidapet_mobile/app/modules/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton((i) => HomeController.new);
  }

  @override
  List<Module> get imports => [
        SupplierCoreModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomePage());
  }
}
