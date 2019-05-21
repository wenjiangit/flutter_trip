import 'dart:convert';
import 'package:flutter_trip/model/search_model.dart';
import 'package:http/http.dart' as http;

const SEARCH_URL = 'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';


class SearchDao{

  ///搜索接口
  static Future<SearchModel> search(String keyWords) async{
    try {
      var response = await http.get(SEARCH_URL+keyWords);
      var convert = Utf8Decoder().convert(response.bodyBytes);
      var decode = json.decode(convert);
      return SearchModel.fromJson(decode);
    } catch (e) {
      throw Exception('search fail ...');
    }
  }
}