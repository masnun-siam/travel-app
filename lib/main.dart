import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:travelguide/screens/tab-navigation-view.dart';

void main() => runApp(ProviderScope(child: TravelApp()));

class TravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(color: Color.fromRGBO(41, 182, 246, 1)),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Lato',
      ),
      home: TabNavigationView(),
//      home: TabNavigationView(),
    );
  }
}
