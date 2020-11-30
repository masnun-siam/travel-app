import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import '../providers/home_provider.dart';
import '../widgets/bottom_navigation.dart';
import 'home.dart';
import 'map_view.dart';

class TabNavigationView extends StatefulWidget {
  @override
  _TabNavigationView createState() => _TabNavigationView();
}

class _TabNavigationView extends State<TabNavigationView> {
  int _index = 0;

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    final homeMdl = context.read<HomeProvider>(placeProvider);
    homeMdl.getAttractionSuggestionList();
    homeMdl.getAttructionList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = <Widget>[
      HomePage(key: PageStorageKey('home')),
      MapView(key: PageStorageKey('map')),
    ];

    return Scaffold(
      body: PageStorage(bucket: _bucket, child: _children.elementAt(_index)),
      bottomNavigationBar: bottomNavigation(_index, _onItemTapped),
    );
  }
}
