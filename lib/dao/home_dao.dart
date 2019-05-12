
import 'package:flutter_trip/model/home_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao{

  ///首页大接口
  static Future<HomeModel> fetch() async{
    final response = await http.get(HOME_URL);
    if(response.statusCode == 200){
      var convert = Utf8Decoder().convert(response.bodyBytes);
      return HomeModel.fromJson(json.decode(convert));
    }else{
      throw Exception('fail to load home_page.json');
    }
  }

}