import 'package:meta/meta.dart';

@immutable
class MapCoordinates {
  final double latitude;
  final double longitude;
  MapCoordinates(this.latitude, this.longitude);
  MapCoordinates.fromMap(Map map)
      : this.latitude = map["latitude"],
        this.longitude = map["longitude"];
  Map toMap() => {
        "latitude": this.latitude,
        "longitude": this.longitude,
      };

  String toString() => "{$latitude,$longitude}";
}

@immutable
class Address {
  final MapCoordinates coordinates;

  final String addressLine;

  final String countryName;

  final String countryCode;

  final String featureName;

  final String postalCode;

  final String adminArea;

  final String subAdminArea;

  final String locality;

  final String subLocality;

  final String thoroughfare;
  final String subThoroughfare;

  Address(
      {this.coordinates,
      this.addressLine,
      this.countryName,
      this.countryCode,
      this.featureName,
      this.postalCode,
      this.adminArea,
      this.subAdminArea,
      this.locality,
      this.subLocality,
      this.thoroughfare,
      this.subThoroughfare});

  /// Creates an address from a map containing its properties.
  Address.fromMap(Map map)
      : this.coordinates = new MapCoordinates.fromMap(map["coordinates"]),
        this.addressLine = map["addressLine"],
        this.countryName = map["countryName"],
        this.countryCode = map["countryCode"],
        this.featureName = map["featureName"],
        this.postalCode = map["postalCode"],
        this.locality = map["locality"],
        this.subLocality = map["subLocality"],
        this.adminArea = map["adminArea"],
        this.subAdminArea = map["subAdminArea"],
        this.thoroughfare = map["thoroughfare"],
        this.subThoroughfare = map["subThoroughfare"];

  /// Creates a map from the address properties.
  Map toMap() => {
        "coordinates": this.coordinates.toMap(),
        "addressLine": this.addressLine,
        "countryName": this.countryName,
        "countryCode": this.countryCode,
        "featureName": this.featureName,
        "postalCode": this.postalCode,
        "locality": this.locality,
        "subLocality": this.subLocality,
        "adminArea": this.adminArea,
        "subAdminArea": this.subAdminArea,
        "thoroughfare": this.thoroughfare,
        "subThoroughfare": this.subThoroughfare,
      };
}
