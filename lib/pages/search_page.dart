import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SearchItem> _searchList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Column(
          children: <Widget>[
            _searchBar(context),
            Expanded(
                child: ListView.builder(
              itemBuilder: _buildItem,
              itemCount: _searchList.length,
            ))
          ],
        ));
  }

  Widget _searchBar(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(16, 10 + paddingTop, 16, 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SearchBar(
              searchType: SearchType.search,
              onTextChanged: _onTextChange,
            ),
          ),
          InkWell(
            onTap: _onSearch,
            child: Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                '搜索',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSearch() {}

  void _onTextChange(String value) async {
    if (value.isEmpty) {
      setState(() {
        _searchList = [];
      });
      return;
    }
    try {
      var searchModel = await SearchDao.search(value);
      setState(() {
        _searchList = searchModel.data;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildItem(BuildContext context, int index) {
    var searchItem = _searchList[index];
    return Container(
      alignment: Alignment.centerLeft,
      height: 40,
      child: Text(searchItem.word),
    );
  }
}
