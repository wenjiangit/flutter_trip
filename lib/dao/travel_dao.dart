import 'dart:convert';
import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:http/http.dart' as http;

const TAB_URL = 'http://www.devio.org/io/flutter_app/json/travel_page.json';

class TravelDao {
  static Future<TravelTabModel> fetch() async {
    var response = await http.get(TAB_URL);
    if (response.statusCode == 200) {
      var convert = Utf8Decoder().convert(response.bodyBytes);
      return TravelTabModel.fromJson(json.decode(convert));
    } else {
      throw Exception('fail to fetch TravelTabModel');
    }
  }

  static Future<TravelModel> fetchContent(String url, Map params, String groupCode) async {
    var body = params..['groupChannelCode'] = groupCode;
    var response = await http.post(url, body: jsonEncode(body));
    if(response.statusCode == 200){
      return TravelModel.fromJson(json.decode(response.body));
    }else{
      throw Exception('fail to fetch TravelModel');
    }
  }
}
