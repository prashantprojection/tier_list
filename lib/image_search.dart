import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageSearch{
final List<Image> _searchResults = [];

/*
  search(String query) async{
var url =
      Uri.https('https://contextualwebsearch-websearch-v1.p.rapidapi.com/api/Search/ImageSearchAPI?q=$query&pageNumber=1&pageSize=10&autoCorrect=true');
      var response = await http.get(url,headers: {
        'X-RapidAPI-Key': 'a4224cc2eemshbdcba77917fd9c4p157f97jsn23bcb07e8d5a',
    'X-RapidAPI-Host': 'contextualwebsearch-websearch-v1.p.rapidapi.com'
      });
      print(response);
      if (response.statusCode==200) {
        print("Successful");
      }
  }
*/

 fetchSearchResults(String query) async {
  _searchResults.clear();
    final response = await http.get(Uri.parse(
      'https://api.unsplash.com/search/photos?query=$query&client_id=j09zz6qA0Dg__RrTV8si7sjKJXdqPpQ-lV0Ptsjab5Y',
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