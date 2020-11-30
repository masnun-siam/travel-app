import 'package:flutter/material.dart';
import 'package:travelguide/screens/places/single-palce-detail.dart';

class AttractionCard extends StatelessWidget {
  final String img;
  final String name;
  final String country;
  final String detail;

  AttractionCard({Key key, this.img, this.name, this.country, this.detail})
      : super(key: key);

  navigateAttractionList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SinglePlaceDetail(
                image: img,
                name: name,
                detail: detail,
                country: country,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: Colors.white),
        child: InkWell(
          onTap: () {
            navigateAttractionList(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 110,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        image: AssetImage(img), fit: BoxFit.cover)),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, left: 5),
                child: Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromRGBO(74, 74, 74, 1)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4, left: 5),
                child: Text(
                  country,
                  style: TextStyle(
                      fontSize: 12, color: Color.fromRGBO(133, 133, 133, 1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
