import 'package:cuidapet_mobile/app/core/exceptions/failure_exception.dart';
import 'package:cuidapet_mobile/app/core/helpers/constantes.dart';
import 'package:cuidapet_mobile/app/core/helpers/environments.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:google_places_rest_api/google_places_rest_api.dart';

import './address_repository.dart';

class ImplAddressRepository implements AddressRepository {
  @override
  Future<List<PlaceModel>> findAddressByGooglePlaces(
      String addressPattern) async {
    final googleApiKey = Environments.param(Constantes.GOOGLE_API_KEY);

    if (googleApiKey == null) {
      throw FailureException(message: "Google Api Key Not Found");
    }

    final googlePlace = GooglePlacesRestApi(googleApiKey: googleApiKey);

    final addressResult =
        await googlePlace.findAutocomplete(query: addressPattern);

    final candidates = addressResult.results;

    return candidates.map<PlaceModel>((searchResult) {
      final location = searchResult.geometry?.location;
      final address = searchResult.formattedAddress;

      return PlaceModel(
        address: address ?? "",
        lat: location?.lat ?? 0,
        lgn: location?.lng ?? 0,
      );
    }).toList();
  }
}
