import 'package:cuidapet_mobile/app/core/database/sqlite_connection_factory.dart';
import 'package:cuidapet_mobile/app/core/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/core/exceptions/failure_exception.dart';
import 'package:cuidapet_mobile/app/core/helpers/constantes.dart';
import 'package:cuidapet_mobile/app/core/helpers/environments.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:google_places_rest_api/google_places_rest_api.dart';

import './address_repository.dart';

class ImplAddressRepository implements AddressRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  ImplAddressRepository({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;
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

  @override
  Future<void> deleteAll() async {
    final sqliteConn = await _sqliteConnectionFactory.openConnection();
    sqliteConn.delete("address");
  }

  @override
  Future<List<AddressEntity>> getAddres() async {
    final sqliteConn = await _sqliteConnectionFactory.openConnection();
    final result = await sqliteConn.rawQuery("select * from address");
    return result.map<AddressEntity>((a) => AddressEntity.fromMap(a)).toList();
  }

  @override
  Future<int> saveAddres(AddressEntity entity) async {
    final sqliteConn = await _sqliteConnectionFactory.openConnection();

    return await sqliteConn.rawInsert(
      "insert into address values(?,?,?,?,?)",
      [
        null,
        entity.address,
        entity.lat,
        entity.lng,
        entity.additional,
      ],
    );
  }
}
