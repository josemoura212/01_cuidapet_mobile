import 'package:flutter_modular/flutter_modular.dart';

import 'schedules_page.dart';

class SchedulesModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const SchedulesPage());
  }
}
