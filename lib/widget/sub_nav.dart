import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> navList;

  const SubNav({Key key, this.navList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: _buildNav(context),
      ),
    );
  }

  Widget _buildNav(BuildContext context) {
    if (navList == null) return null;
    var list = navList.map((model) => _item(context, model)).toList();
    final int separate = (navList.length / 2 + 0.5).toInt();
    return Column(
      children: <Widget>[
        Row(
          children: list.sublist(0, separate),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: list.sublist(separate, navList.length),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(
            title: model.title,
            url: model.url,
            statusBarColor: model.statusBarColor,
            hideAppBar: model.hideAppBar,
          );
        }));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            width: 20,
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              model.title,
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    ));
  }
}
