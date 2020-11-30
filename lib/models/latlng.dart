import 'dart:convert';

class LatLng {
  final double lat;
  final double lng;
  LatLng({
    this.lat,
    this.lng,
  });
  

  LatLng copyWith({
    double lat,
    double lng,
  }) {
    return LatLng(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  factory LatLng.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return LatLng(
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LatLng.fromJson(String source) => LatLng.fromMap(json.decode(source));

  @override
  String toString() => 'LatLng(lat: $lat, lng: $lng)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is LatLng &&
      o.lat == lat &&
      o.lng == lng;
  }

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}
