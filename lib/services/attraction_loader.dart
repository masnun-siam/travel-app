import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:travelguide/models/attractions.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

final String apiKey =
    '5ae2e3f221c38a28845f05b6cad183c55fda7532974da9473ef17bd0';
final String baseUrl = 'https://api.opentripmap.com/0.1/en';

Future<List<AttractionCategory>> getAttractionData() async {
  String data =
      await rootBundle.loadString('assets/data_resources/attractionsData.json');
  Iterable js = json.decode(data);
  List<AttractionCategory> attractions = js.map<AttractionCategory>((model) {
    return AttractionCategory.fromJson(model);
  }).toList();

  return attractions;
}

Stream<List<Attraction>> getSuggestionsData() async* {
  try {
    final location = Location.instance;
    final userLoc = await location.getLocation().timeout(
          Duration(seconds: 7),
          onTimeout: () => null,
        );
    final result = await http.get(
        '$baseUrl/places/radius?radius=100000&lon=${userLoc?.longitude ?? 23.8103}&lat=${userLoc?.latitude ?? 23.8103}&apikey=$apiKey');
    if (result.statusCode == 200) {
      final jsonBody = json.decode(result.body);
      final list = (jsonBody['features'] as List)
          .map((e) => e['properties']['xid'])
          .toList();
      final xidList = list.getRange(0, 100).toList();
      // print(xidList);
      List<Attraction> attractionList = [];
      for (var xid in xidList) {
        var xidResult =
            await http.get('$baseUrl/places/xid/$xid?apikey=$apiKey');
        if (xidResult.statusCode == 200) {
          var placesJson = json.decode(xidResult.body);
          if (placesJson['name'] == null || placesJson['name'] == '') continue;
          attractionList.add(Attraction.fromJson(placesJson));
          yield attractionList;
        } else {
          yield [];
        }
      }
    } else {
      yield [];
    }
  } catch (e) {
    log(e.toString());
    yield [];
  }
}

Stream<List<Attraction>> getTopRatedData() async* {
  final result = await http.get(
      '$baseUrl/places/radius?radius=10000&lon=0.12&lat=52.52&apikey=$apiKey');
  // print("fetched");
  if (result.statusCode == 200) {
    final jsonBody = json.decode(result.body);
    final list = (jsonBody['features'] as List)
        .map((e) => e['properties']['xid'])
        .toList();
    final xidList = list.getRange(0, 100).toList();
    //print(xidList);
    List<Attraction> attractionList = [];
    for (var xid in xidList) {
      var xidResult = await http.get('$baseUrl/places/xid/$xid?apikey=$apiKey');
      if (xidResult.statusCode == 200) {
        var placesJson = json.decode(xidResult.body);
        if (placesJson['name'] == null || placesJson['name'] == '') continue;
        // print(placesJson['name']);
        attractionList.add(Attraction.fromJson(placesJson));
        yield attractionList;
      } else {
        yield [];
      }
    }
  } else {
    yield [];
  }
}
