import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thoai/map/component/key_map.dart';



class PickerMap extends StatefulWidget {
  final KeyMap bloc;
  PickerMap(this.bloc);

  @override
  State<PickerMap> createState() => PickerMapState();
}

class PickerMapState extends State<PickerMap> {
  final List<Marker> _allMarkers = [];
  GoogleMapController _mapController;
  LatLng _latLng = LatLng(10.85636,106.6543,);
  LatLng _currentPostion;
  Coordinates _coordinates;
  List<Address> _addresses;
  Address _first;

  void _updateMarker(String id, double lat, double lng,
      [String name, String snippet]) async {
    var marker = _allMarkers.firstWhere(
      (p) => p.markerId == MarkerId(id),
      orElse: () => null,
    );
    _allMarkers.remove(marker);

    _coordinates = Coordinates(lat, lng);
    _addresses =
        await Geocoder.local.findAddressesFromCoordinates(_coordinates);
    setState(() {
      _first = _addresses.first;
      widget.bloc.addressController.sink.add(_first);
    });

    if (name != null && snippet != null) {
      _allMarkers.add(
        Marker(
          markerId: MarkerId(id),
          position: LatLng(lat, lng),
          draggable: true,
          infoWindow: InfoWindow(
            title: name,
            snippet: snippet,
          ),
        ),
      );
    } else {
      _allMarkers.add(
        Marker(
          markerId: MarkerId(id),
          position: LatLng(lat, lng),
          draggable: true,
          infoWindow: InfoWindow(
            title: _first.featureName,
            snippet: _first.addressLine,
          ),
        ),
      );
    }

    if (mounted) {
      setState(() {
        _latLng = LatLng(lat, lng);
      });
    }
  }

  void _onMapCreated(GoogleMapController googleMapController) {
    if (mounted) {
      setState(() {
        _mapController = googleMapController;

        Future.delayed(Duration(seconds: 3), () {
          if (_currentPostion != null) {
            _mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: _currentPostion,
                  zoom: 18,
                ),
              ),
            );
            _updateMarker('sAzi-MarkerId', _currentPostion.latitude,
                _currentPostion.longitude);
          } else {
            _updateMarker('sAzi-MarkerId', _latLng.latitude, _latLng.longitude);
          }
        });
      });
    }
  }

  void _getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    if (mounted) {
      setState(() {
        _currentPostion = LatLng(position.latitude, position.longitude);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    widget.bloc.locationController.stream.listen(
      (location) async {
        _mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                location.lat,
                location.lng,
              ),
              zoom: 18.0,
            ),
          ),
        );
        _updateMarker('sAzi-MarkerId', location.lat, location.lng,
            location.name, location.formattedAddress);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _latLng,
          zoom: 18,
        ),
        mapType: MapType.normal,
        markers: Set.from(_allMarkers),
        onMapCreated: _onMapCreated,
        onTap: (latlng) async {
          await _mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: latlng,
                zoom: 18,
              ),
            ),
          );
          _updateMarker('sAzi-MarkerId', latlng.latitude, latlng.longitude);
        },
        myLocationEnabled: true,
      ),
    );
  }
}
