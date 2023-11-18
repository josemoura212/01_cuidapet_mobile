import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/app/services/address/address_service.dart';
import 'package:mobx/mobx.dart';
part 'address_search_widget_controller.g.dart';

class AddressSearchWidgetController = AddressSearchWidgetControllerBase
    with _$AddressSearchWidgetController;

abstract class AddressSearchWidgetControllerBase with Store {
  final AddressService _addressService;

  AddressSearchWidgetControllerBase({
    required AddressService addressService,
  }) : _addressService = addressService;

  Future<List<PlaceModel>> searchAddress(String addressPattern) =>
      _addressService.findAddressByGooglePlaces(addressPattern);
}
