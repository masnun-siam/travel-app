import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:travelguide/providers.dart';
import 'package:travelguide/screens/places/single-palce-detail.dart';
import 'package:travelguide/services/search_destination.dart';
import 'package:travelguide/widgets/home/sugessions.dart';
import 'package:travelguide/widgets/search-card.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              width: width,
              height: isPortrait ? height / 2 : width / 2,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(60.0)),
                  image: DecorationImage(
                      image: AssetImage('assets/img004.jpg'),
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.7), BlendMode.dstATop),
                      fit: BoxFit.cover)),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 80.0),
                    child: Text(
                      "Where you want to go ?",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                  Consumer(builder: (context, read, child) {
                    final response = read(searchProvider);
                    return Container(
                      child: searchCard(
                          (value) {}, response.searchController, width,
                          () async {
                        final attraction = await getSearchDetail(
                            response.searchController.text.trim());
                        if (attraction != null) {
                          response.searchController.clear();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SinglePlaceDetail(
                                    name: attraction.name.toUpperCase(),
                                    country: attraction.country,
                                    detail: attraction.detail,
                                    image: attraction.image,
                                  )));
                        } else {
                          FlushbarHelper.createError(message: 'Error occured')
                              .show(context);
                        }
                      }),
                    );
                  }),
                ],
              ),
            ),
            Consumer(builder: (context, watch, child) {
              final response = watch(placeProvider);
              return Container(
                padding: EdgeInsets.all(8.0),
                child: (response.topRatedPlaces == [])
                    ? CircularProgressIndicator()
                    : attractionSection(response.topRatedPlaces, "Top Rated"),
              );
            }),
            Consumer(
              builder: (context, watch, child) {
                final response = watch(placeProvider);
                return Container(
                  padding: EdgeInsets.all(8.0),
                  child: (response.suggestionList == [])
                      ? CircularProgressIndicator()
                      : attractionSection(
                          response.suggestionList, "Suggested for you"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
