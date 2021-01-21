
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CityAddress {
  final name;
  final id;
  CityAddress({this.name, this.id});

  //key api
  static const apiMap = "https://devapi.azitask.com",namespace = "/api/ResCountryArea/AppsByCountryID_Rows";

  static Future<List<CityAddress>>
   getCityAddress({@required String countryId}) async {
    List<CityAddress> list;
    final response = await http.post(
      '$apiMap$namespace',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{"searchTextMap": "", "CountryId": countryId}));
    try {
      if (response.statusCode == 200 && response.body != null) {
        final results = response.body;
        final parsed = jsonDecode(results).cast<Map<String, dynamic>>();
        list = await parsed.map<CityAddress>((json) => CityAddress.fromJson(json)).toList();
        return list;
      }
    } catch (e) {
      return null;
    }
  }
  factory CityAddress.fromJson(Map<String, dynamic> json) {
    return CityAddress(name: json['Name'], id: json['Id']);
  }
}
