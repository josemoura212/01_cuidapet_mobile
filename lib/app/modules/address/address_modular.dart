import 'package:cuidapet_mobile/app/modules/address/address_page.dart';
import 'package:cuidapet_mobile/app/modules/address/widgets/address_search_widget/address_search_widget_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddressModular extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton(
          (i) => AddressSearchWidgetController(addressService: i()),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const AddressPage()),
      ];
}
