import 'package:flutter/foundation.dart';
import 'package:travelguide/models/attractions.dart';
import 'package:travelguide/services/attraction_loader.dart';

class HomeProvider with ChangeNotifier {
  List<Attraction> suggestionList = [];
  List<Attraction> topRatedPlaces = [];

  getAttractionSuggestionList() async {
    getSuggestionsData().listen((res) {
      suggestionList = res;
      notifyListeners();
    });
  }

  getAttructionList() async {
    getTopRatedData().listen((event) {
      topRatedPlaces = event;
      notifyListeners();
    });
  }
}
