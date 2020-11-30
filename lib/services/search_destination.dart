import 'package:travelguide/models/attractions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:travelguide/services/attraction_loader.dart';

Future<Attraction> getSearchDetail(String input) async {
  print(input);
  final result = await http.get(
      '$baseUrl/places/geoname?name=$input&apikey=$apiKey');
  if (result.statusCode == 200) {
    final jsonBody = json.decode(result.body);
    final attraction = Attraction(
      name: jsonBody['name'],
      country: jsonBody['country'],
      image: noImage,
      detail:
          'TimeZone: ${jsonBody["timezone"]}\nNo additional details provided',
      shortDetail: 'Not provided',
      xid: '',
    );
    print('Attraction: ${attraction.name}');
    return attraction;
  } else {
    return null;
  }
}
