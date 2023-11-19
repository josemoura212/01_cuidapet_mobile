import 'package:cuidapet_mobile/app/modules/address/address_controller.dart';
import 'package:cuidapet_mobile/app/modules/address/address_detail/address_detail_module.dart';
import 'package:cuidapet_mobile/app/modules/address/address_page.dart';
import 'package:cuidapet_mobile/app/modules/address/widgets/address_search_widget/address_search_widget_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddressModular extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => AddressController(addressService: i())),
        Bind.lazySingleton(
          (i) => AddressSearchWidgetController(addressService: i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const AddressPage()),
        ModuleRoute("/detail", module: AddressDetailModule())
      ];
}
