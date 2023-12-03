import 'package:cuidapet_mobile/app/repositories/supplier/supplier_repository.dart';
import 'package:cuidapet_mobile/app/repositories/supplier/supplier_repository_impl.dart';
import 'package:cuidapet_mobile/app/services/supplier/supplier_service.dart';
import 'package:cuidapet_mobile/app/services/supplier/supplier_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SupplierCoreModule extends Module {
  @override
  void exportedBinds(i) => i
    ..addLazySingleton<SupplierRepository>(SupplierRepositoryImpl.new)
    ..addLazySingleton<SupplierService>(SupplierServiceImpl.new);
}
