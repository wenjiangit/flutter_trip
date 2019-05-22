import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/model/search_model.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/webview.dart';

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

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
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(
            url: searchItem.url,
            title: '详情',
          );
        }));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f2f2), width: 0.5))),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: _typeIcon(searchItem.type),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: _title(searchItem),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: _subTitle(searchItem),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _title(SearchItem item) {
    if (item == null) return null;
    var split = item.word.split(_keyWords);
    List<TextSpan> spans = [];

    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black);
    TextStyle keywordStyle =
        TextStyle(fontSize: 16, color: Colors.orangeAccent);
    for (var i = 0; i < split.length; i++) {
      if (i % 2 == 1) {
        spans.add(TextSpan(text: _keyWords, style: keywordStyle));
      }
      spans.add(TextSpan(text: split[i], style: normalStyle));
    }

    spans.add(TextSpan(
        text: ' ${item.districtname ?? ''}  ${item.zonename ?? ''}',
        style: TextStyle(fontSize: 16, color: Colors.grey)));

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  Widget _subTitle(SearchItem item) {
    if (item == null) return null;
    return RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: '${item.price ?? ''} ',
          style: TextStyle(fontSize: 16, color: Colors.orange)),
      TextSpan(
          text: item.star ?? '',
          style: TextStyle(fontSize: 14, color: Colors.grey)),
    ]));
  }

  _typeIcon(String type) {
    String myType = "travelgroup";
    for (final typeName in TYPES) {
      if (typeName.contains(type)) {
        myType = typeName;
        break;
      }
    }
    return Image.asset(
      'images/type_$myType.png',
      width: 30,
      height: 30,
    );
  }
}
