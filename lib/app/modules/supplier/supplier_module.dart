import 'package:cuidapet_mobile/app/modules/core/supplier/supplier_core_module.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'supplier_page.dart';

class SupplierModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(SupplierController.new);
  }

  @override
  List<Module> get imports => [
        SupplierCoreModule(),
      ];

  @override
  void routes(RouteManager r) {
    final args = r.args;
    r.child('/', child: (context) => SupplierPage(supplierId: args.data));
  }
}
