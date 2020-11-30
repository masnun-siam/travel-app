import 'package:flutter_riverpod/all.dart';
import 'package:location/location.dart';
import 'package:travelguide/providers/search_provider.dart';

import 'providers/home_provider.dart';

final placeProvider = ChangeNotifierProvider((res) => HomeProvider());
final searchProvider = Provider((res) => SearchProvider());

final locationProvider = FutureProvider<LocationData>((res) async {
  final location = Location.instance;
  return location.getLocation();
});
