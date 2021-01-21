import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class WardAddress {
  final name;
  final id;
  WardAddress({this.name, this.id});

  //key API
  static const apiMap = "https://devapi.azitask.com",namespace = "/api/ResCountrySubTerritory/AppsByTerritoryID_Rows";

  static Future<List<WardAddress>> getWardsAddress(
      {@required String countryTerritoryId}) async {
    List<WardAddress> list;
    final response = await http.post('$apiMap$namespace',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "searchTextMap": "",
          "CountryTerritoryId": countryTerritoryId
        }));
    try {
      if (response.statusCode == 200 && response.body != null) {
        final results = response.body;
        final parsed = jsonDecode(results).cast<Map<String, dynamic>>();
        list = await parsed.map<WardAddress>((json) => WardAddress.fromJson(json)).toList();
        return list;
      }
    } catch (e) {

      return null;
    }
  }
  factory WardAddress.fromJson(Map<String, dynamic> json) {
    return WardAddress(name: json['Name'], id: json['Id']);
  }
}