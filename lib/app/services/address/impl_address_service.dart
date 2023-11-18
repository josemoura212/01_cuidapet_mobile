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
}
