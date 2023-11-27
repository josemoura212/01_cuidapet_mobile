import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/core/exceptions/failure_exception.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client_exception.dart';
import 'package:cuidapet_mobile/app/models/supplier_category_model.dart';
import 'package:cuidapet_mobile/app/models/supplier_nearby_me_model.dart';

import './supplier_repository.dart';

class SupplierRepositoryImpl implements SupplierRepository {
  final RestClient _restClient;
  final AppLogger _log;

  SupplierRepositoryImpl(
      {required RestClient restClient, required AppLogger log})
      : _restClient = restClient,
        _log = log;
  @override
  Future<List<SupplierCategoryModel>> getCategories() async {
    try {
      final result = await _restClient.auth().get("/categories/");
      return result.data
          ?.map<SupplierCategoryModel>((categoryResponse) =>
              SupplierCategoryModel.fromMap(categoryResponse))
          .toList();
    } on RestClientException catch (e, s) {
      const message = "Erro ao buscar categorias dos fornecedores";
      _log.error(message, e, s);
      throw FailureException(message: message);
    }
  }

  @override
  Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity address) async {
    try {
      final result =
          await _restClient.auth().get("/suppliers/", queryParameters: {
        "lat": address.lat,
        "lng": address.lng,
      });

      return result.data
          ?.map<SupplierNearbyMeModel>((supplierResponse) =>
              SupplierNearbyMeModel.fromMap(supplierResponse))
          .toList();
    } on RestClientException catch (e, s) {
      const message = "Erro ao buscar forncedores perto de mim";
      _log.error(message, e, s);
      throw FailureException(message: message);
    }
  }
}
