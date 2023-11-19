import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';

abstract class AddressService {
  Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern);
  Future<List<AddressEntity>> getAddres();
  Future<AddressEntity> saveAddres(PlaceModel place, String additional);
  Future<void> deleteAll();
}
