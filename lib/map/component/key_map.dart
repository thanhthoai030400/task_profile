import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'package:geocoder/geocoder.dart';
import 'package:thoai/map/component/location.dart';


class KeyMap with ChangeNotifier {
  StreamController<Location> locationController =
      StreamController<Location>.broadcast();
  Location currentLocation;
  Address address;
  static const mapKey = 'AIzaSyA-XiJN3FSmC1xvtuYemqiQH3lQ8yWvT2s';


  static KeyMap _instance;
  static KeyMap getInstance() {
    if (_instance == null) {
      _instance = KeyMap._internal();
    }
    return _instance;
  }

  StreamController<Address> addressController =StreamController<Address>.broadcast();
  KeyMap._internal();

  Future<List<Location>> search(String query) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$mapKey";
    Response response = await Dio().get(url);
    return Location.parseLocationList(response.data);
  }

  void locationSelected(Location location) {
    locationController.sink.add(location);
  }

  void popLocationSelected(Address location) {
    addressController.sink.add(location);
  }

  void setLocationByMovingMap(Location location) {
    currentLocation = location;
  }

  void dispose() {
    _instance = null;
    locationController.close();
    addressController.close();
  }
}
