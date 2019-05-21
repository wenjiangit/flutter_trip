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

  String _keyWords;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Column(
          children: <Widget>[
            _appbar(context),
            MediaQuery.removePadding(
              removeTop: true,
                context: context,
                child: Expanded(
                    child: ListView.builder(
                  itemBuilder: _buildItem,
                  itemCount: _searchList?.length ?? 0,
                )))
          ],
        ));
  }

  Widget _appbar(BuildContext context) {
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
    _keyWords = value;
    if (value.isEmpty) {
      setState(() {
        _searchList = [];
      });
      return;
    }
    try {
      var searchModel = await SearchDao.fetch(value);
      //当返回的结果与最新输入的关键字一致时才进行渲染
      if (searchModel.keyWords == _keyWords) {
        setState(() {
          _searchList = searchModel.data;
        });
      }
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
