import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:latlong/latlong.dart';
import 'package:travelguide/providers.dart';
import 'package:travelguide/screens/places/single-palce-detail.dart';

class MapView extends StatelessWidget {
  MapView({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MapView'),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final response = watch(placeProvider);
          final locationResponse = watch(locationProvider);
          final List<Marker> markers = response.suggestionList.map((e) {
            return Marker(
              point: LatLng(e.lat, e.lng),
              builder: (context) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SinglePlaceDetail(
                      image: e.image,
                      name: e.name,
                      country: e.country,
                      detail: e.detail,
                      lat: e.lat,
                      lng: e.lng,
                    ),
                  ));
                },
                child: Image.asset(
                  'assets/map/marker.png',
                ),
              ),
              height: 50.0,
              width: 50.0,
            );
          }).toList();
          return locationResponse.map(
            data: (locData) {
              return MapLoader(
                markers: markers,
                center: LatLng(
                  locData.value.latitude,
                  locData.value.longitude,
                ),
              );
            },
            loading: (_) {
              return Center(child: CircularProgressIndicator());
            },
            error: (_) {
              return MapLoader(
                markers: markers,
                center: LatLng(23.8103, 90.4125),
              );
            },
          );
        },
      ),
    );
  }
}

class MapLoader extends StatefulWidget {
  final List<Marker> markers;
  final LatLng center;

  const MapLoader({Key key, this.markers, this.center}) : super(key: key);
  @override
  _MapLoaderState createState() => _MapLoaderState();
}

class _MapLoaderState extends State<MapLoader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FlutterMap(
          options: MapOptions(
            center: widget.center,
            zoom: 16.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
              markers: widget.markers,
            ),
          ],
        ),
      ),
    );
  }
}
