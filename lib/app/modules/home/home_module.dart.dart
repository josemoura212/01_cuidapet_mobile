import 'package:cuidapet_mobile/app/modules/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModuleDart extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
