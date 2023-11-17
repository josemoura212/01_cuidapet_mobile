import 'package:cuidapet_mobile/app/core/exceptions/failure_exception.dart';
import 'package:cuidapet_mobile/app/core/helpers/constantes.dart';
import 'package:cuidapet_mobile/app/core/helpers/environments.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';

import './address_repository.dart';

class ImplAddressRepository implements AddressRepository {
  @override
  Future<List<PlaceModel>> findAddressByGooglePlaces(
      String addressPattern) async {
    final googleApiKey = Environments.param(Constantes.GOOGLE_API_KEY);

    if (googleApiKey == null) {
      throw FailureException(message: "Google Api Key Not Found");
    }
    final googlePlace = FlutterGooglePlacesSdk(googleApiKey);
    final addressResult =
        await googlePlace.findAutocompletePredictions(addressPattern);

    final candidates = addressResult.predictions;
  }
}
