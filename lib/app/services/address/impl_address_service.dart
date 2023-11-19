import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/repositories/address/address_repository.dart';

import './address_service.dart';

class ImplAddressService implements AddressService {
  final AddressRepository _addressRepository;

  ImplAddressService({required AddressRepository addressRepository})
      : _addressRepository = addressRepository;
  @override
  Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern) =>
      _addressRepository.findAddressByGooglePlaces(addressPattern);

  @override
  Future<void> deleteAll() => _addressRepository.deleteAll();

  @override
  Future<List<AddressEntity>> getAddres() => _addressRepository.getAddres();

  @override
  Future<AddressEntity> saveAddres(PlaceModel place, String additional) async {
    final addressEntity = AddressEntity(
      id: null,
      address: place.address,
      lat: place.lat,
      lng: place.lng,
      additional: additional,
    );
    final addresId = await _addressRepository.saveAddres(addressEntity);
    return addressEntity.copyWith(id: () => addresId);
  }
}
