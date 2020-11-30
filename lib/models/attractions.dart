

final noImage =
    'https://www.lookatourworld.com/wp-content/uploads/2018/08/No-Image-Provided-1.png';

class Attraction {
  String xid;

  String country;
  String detail;
  String image;
  String name;
  String shortDetail;
  double lat;
  double lng;
  Attraction({
    this.xid,
    this.country,
    this.detail,
    this.image,
    this.name,
    this.shortDetail,
    this.lat,
    this.lng,
  });
  factory Attraction.fromJson(Map<String, dynamic> json) => Attraction(
        xid: json['xid'],
        name: json['name'] ?? '',
        detail: (json['wikipedia_extracts'] == null)
            ? json['kinds'] ?? 'No details provided'
            : json['wikipedia_extracts']['text'],
        shortDetail: json['wikipedia'] ?? 'No details provided',
        image: json['preview'] == null ? noImage : json['preview']['source'],
        country: json['address']['country'] ?? '',
        lat: (json['point']['lat'] as num).toDouble(),
        lng: (json['point']['lon'] as num).toDouble(),
      );

  Attraction copyWith({
    String xid,
    String country,
    String detail,
    String image,
    String name,
    String shortDetail,
    double lat,
    double lng,
  }) {
    return Attraction(
      xid: xid ?? this.xid,
      country: country ?? this.country,
      detail: detail ?? this.detail,
      image: image ?? this.image,
      name: name ?? this.name,
      shortDetail: shortDetail ?? this.shortDetail,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

 

  @override
  String toString() {
    return 'Attraction(xid: $xid, country: $country, detail: $detail, image: $image, name: $name, shortDetail: $shortDetail, lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Attraction &&
      o.xid == xid &&
      o.country == country &&
      o.detail == detail &&
      o.image == image &&
      o.name == name &&
      o.shortDetail == shortDetail &&
      o.lat == lat &&
      o.lng == lng;
  }

  @override
  int get hashCode {
    return xid.hashCode ^
      country.hashCode ^
      detail.hashCode ^
      image.hashCode ^
      name.hashCode ^
      shortDetail.hashCode ^
      lat.hashCode ^
      lng.hashCode;
  }
}

class AttractionCategory {
  List<Attraction> attractions;

  String category;

  AttractionCategory({
    this.category,
    this.attractions,
  });
  factory AttractionCategory.fromJson(Map<String, dynamic> json) =>
      AttractionCategory(
        category: json['category'],
        attractions: json['attractions'] != null
            ? (json['attractions'] as List)
                .map((value) => new Attraction.fromJson(value))
                .toList()
            : [],
      );
}
