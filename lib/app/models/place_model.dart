class PlaceModel {
  String address;
  double lat;
  double lgn;
  PlaceModel({
    required this.address,
    required this.lat,
    required this.lgn,
  });

  @override
  String toString() => 'PlaceModel(address: $address, lat: $lat, lgn: $lgn)';
}
