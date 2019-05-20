import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('搜索'),
        ),
        body: SearchBar(
          searchType: SearchType.search,
          defaultContent: "adadadadadad",
        ));
  }
}
