import 'package:cuidapet_mobile/app/core/database/sql_adm_connection.dart';
import 'package:cuidapet_mobile/app/core/ui/ui_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:asuka/asuka.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final sqlAdmConnection = SqlAdmConnection();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(sqlAdmConnection);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(sqlAdmConnection);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute("/auth/");
    Modular.setObservers([Asuka.asukaHeroController]);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp.router(
        builder: Asuka.builder,
        debugShowCheckedModeBanner: false,
        title: UiConfig.title,
        theme: UiConfig.theme,
        routerConfig: Modular.routerConfig,
      ),
    );
  }
}
