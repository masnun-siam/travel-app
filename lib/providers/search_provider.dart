import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  String searchInput;

  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
