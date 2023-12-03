import 'package:cuidapet_mobile/app/modules/address/address_controller.dart';
import 'package:cuidapet_mobile/app/modules/address/address_detail/address_detail_module.dart';
import 'package:cuidapet_mobile/app/modules/address/address_page.dart';
import 'package:cuidapet_mobile/app/modules/address/widgets/address_search_widget/address_search_widget_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddressModule extends Module {
  @override
  void binds(i) {
    i.add((i) => AddressController.new, key: "AddressController");
    i.add(
      (i) => AddressSearchWidgetController.new,
      key: "AddressSearchWidgetController",
    );
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const AddressPage());
    r.module("/detail", module: AddressDetailModule());
  }
}
