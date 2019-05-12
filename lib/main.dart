import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/navigator/navigator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabNavigator(),
    );
  }
}

class HttpDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HttpDemoState();
  }
}

class _HttpDemoState extends State<HttpDemo> {
  Future<CommonModel> _fetch() async {
    final response = await http
        .get('http://www.devio.org/io/flutter_app/json/test_common_model.json');
    var result = json.decode(Utf8Decoder().convert(response.bodyBytes));
    await Future.delayed(Duration(seconds: 2));
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'http',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('HttpDemo'),
          ),
          body: FutureBuilder<CommonModel>(
              future: _fetch(),
              builder:
                  (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Text('none'),
                    );
                  case ConnectionState.active:
                    return Center(
                      child: Text('active'),
                    );
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'error',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(snapshot.data.toJson().toString()),
                      );
                    }
                }
              })),
    );
  }
}


