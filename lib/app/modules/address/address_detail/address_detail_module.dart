import 'package:cuidapet_mobile/app/modules/address/address_detail/address_detail_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'address_detail_page.dart';

class AddressDetailModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton((i) => AddressDetailController.new,
        key: "AddressDetailController");
  }

  @override
  void routes(RouteManager r) {
    final args = r.args;
    r.child('/', child: (contex) => AddressDetailPage(place: args.data));
  }
}
