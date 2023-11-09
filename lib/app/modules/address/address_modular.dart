import 'package:cuidapet_mobile/app/modules/address/address_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddressModular extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const AddressPage()),
      ];
}
