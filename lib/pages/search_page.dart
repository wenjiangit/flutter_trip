import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              _setValue();
            },
            child: Text('增加值'),
          ),
          RaisedButton(
            onPressed: () {
              _getValue();
            },
            child: Text('get value $_current'),
          )
        ],
      ),
    );
  }

  _setValue() async {
    var instance = await SharedPreferences.getInstance();
    var value = instance.getInt('counter') ?? 0;
    await instance.setInt('counter', ++value);
  }

  _getValue() async {
    final instance = await SharedPreferences.getInstance();
    setState(() {
      _current = instance.getInt('counter');
    });
  }
}
