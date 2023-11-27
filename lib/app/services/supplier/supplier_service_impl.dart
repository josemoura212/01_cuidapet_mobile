import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';
import 'package:cuidapet_mobile/app/repositories/supplier/supplier_repository.dart';

import './supplier_service.dart';

class SupplierServiceImpl implements SupplierService {
  final SupplierRepository _repository;

  SupplierServiceImpl({
    required SupplierRepository repository,
  }) : _repository = repository;
  @override
  Future<List<SupplierCategoryModel>> getCategories() =>
      _repository.getCategories();

  @override
  Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity address) =>
      _repository.findNearBy(address);
}
