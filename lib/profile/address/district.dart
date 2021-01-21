import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DistrictAddress {
  final name;
  final id;



  DistrictAddress({this.name, this.id});

  //key api
  static const apiMap = "https://devapi.azitask.com", namespace = "/api/ResCountryTerritory/AppsByAreaID_Rows";
  static Future<List<DistrictAddress>> 
  getDistricAddress({@required String countryAreaId}) async {
    List<DistrictAddress> list;
    final response = await http.post('$apiMap$namespace',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "searchTextMap": "",
          "CountryAreaId": countryAreaId
        }));
    try {
      if (response.statusCode == 200 && response.body != null) {
        final results = response.body;
        final parsed = jsonDecode(results).cast<Map<String, dynamic>>();
        list = await parsed
            .map<DistrictAddress>((json) => DistrictAddress.fromJson(json))
            .toList();
        return list;
      }
    } catch (e) {
     
      return null;
    }
  }
  factory DistrictAddress.fromJson(Map<String, dynamic> json) {
    return DistrictAddress(name: json['Name'], id: json['Id']);
  }
}