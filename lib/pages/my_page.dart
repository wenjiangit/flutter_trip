import 'package:flutter/material.dart';
import 'package:flutter_trip/basics/list_view_usage.dart';

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('基本组件'),
      ),
      body: ListView(
        children: <Widget>[
          _buildListItem('ListView用法', ListViewUse()),
//          _buildListItem('listview', () {}),
//          _buildListItem('listview', () {}),
//          _buildListItem('listview'),
//          _buildListItem('listview'),
//          _buildListItem('listview'),
//          _buildListItem('listview'),
//          _buildListItem('listview'),
//          _buildListItem('listview'),
//          _buildListItem('listview'),
//          _buildListItem('listview'),
//          _buildListItem('listview'),
        ],
      ),
    );
  }

  _buildListItem(String title, Widget w) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => w));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16),
        alignment: Alignment.centerLeft,
        height: 50,
        child: Text(title),
      ),
    );
  }
}
