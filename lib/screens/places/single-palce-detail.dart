import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:travelguide/screens/map_view.dart';

class SinglePlaceDetail extends StatefulWidget {
  @required final String image;
  @required final String name;
  @required final String detail;
  @required final String country;
  @required final double lat;
  @required final double lng;

  SinglePlaceDetail(
      {this.image, this.name, this.detail, this.country, this.lat, this.lng});

  @override
  _SinglePlaceDetailState createState() => _SinglePlaceDetailState();
}

class _SinglePlaceDetailState extends State<SinglePlaceDetail> {
  bool isFavourite = false;

  _addToFavourite() {
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: width,
              height: height / 2,
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(60.0)),
                  image: DecorationImage(
                      image: NetworkImage(widget.image), fit: BoxFit.cover)),
              child: Container(
                padding: EdgeInsets.only(top: 20),
                child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Text(
                            widget.name,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(74, 74, 74, .9)),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 0,
                          child: Container(
                              child: IconButton(
                                  icon: Icon(
                                    isFavourite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  onPressed: _addToFavourite))),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8, bottom: 12),
                    child: Text(
                      widget.country,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(112, 112, 112, 1)),
                    ),
                  ),
                  Container(
    
                    child: Text(widget.detail,
                        style: TextStyle(
                            fontSize: 13,
                            height: 1.6,
                            color: Color.fromRGBO(51, 51, 51, 1))),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    color: Colors.teal[300],
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapLoader(
                              markers: [
                                Marker(
                                  height: 50.0,
                                  width: 50.0,
                                  point: LatLng(widget.lat, widget.lng),
                                  builder: (context) => Image.asset(
                                    'assets/map/marker.png',
                                  ),
                                ),
                              ],
                              center: LatLng(widget.lat, widget.lng),
                            ),
                          ),
                        );
                      },
                      child: Text('Show in map',
                          style: TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: Colors.black)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
