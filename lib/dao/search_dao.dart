import 'dart:convert';
import 'package:flutter_trip/model/search_model.dart';
import 'package:http/http.dart' as http;

const SEARCH_URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

class SearchDao {
  ///搜索接口
  static Future<SearchModel> fetch(String keyWords) async {
    var response = await http.get(SEARCH_URL + keyWords);
    if (response.statusCode == 200) {
      var convert = Utf8Decoder().convert(response.bodyBytes);
      var decode = json.decode(convert);
      var searchModel = SearchModel.fromJson(decode);
      return searchModel..keyWords = keyWords;
    } else {
      throw Exception('search fail ...');
    }
  }
}
