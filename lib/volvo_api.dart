import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

const baseUrl = "https://api.volvocars.com/connected-vehicle/v2/vehicles";

class Vin {
    final String vinValue;

    const Vin({required this.vinValue});

    factory Vin.fromJson(Map<String, dynamic> json) {
        return switch(json) {
          {
            "vin": String vinValue,
          } => Vin(vinValue: vinValue)
          },
          _ => throw const FormatException('Failed to load vin, from ${json}');
        }
    }
}


Future<Vin> fetchVins() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Vin.fromJson(data as Map<String, dynamic>);
    }
    else {
        throw Exception('Failed to load vins, status code: ${response.statusCode}');
    }


}
