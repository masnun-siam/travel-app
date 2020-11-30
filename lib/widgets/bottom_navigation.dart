import 'package:flutter/material.dart';
import 'package:travelguide/global/styles.dart';

Widget bottomNavigation(int index, Function onItemTapped) {
  return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 24,
            child: Icon(
              Icons.home,
              size: 20.0,
            ),
          ),
          label: 'Home',
        ),
        
        
        BottomNavigationBarItem(
          icon: SizedBox(
            height: 24,
            child: Icon(
              Icons.map,
              size: 20.0,
            ),
          ),
          label: 'Map',
        ),
      ],
      currentIndex: index,
      selectedItemColor: kBlue,
      unselectedItemColor: kGrey,
      selectedFontSize: 12,
      onTap: onItemTapped,
      backgroundColor: Colors.white,
      elevation: 18,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true);
}
