import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageSearch{
final List<Image> _searchResults = [];

 fetchSearchResults(String query) async {
  _searchResults.clear();
    final response = await http.get(Uri.parse(
      'https://api.unsplash.com/search/photos?query=$query&client_id=API-Key',
    ));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      data['results'].forEach((result) {
        _searchResults.add(Image.network(result['urls']['regular'],fit: BoxFit.fill,));
      });
  }
  return _searchResults;
}

}
