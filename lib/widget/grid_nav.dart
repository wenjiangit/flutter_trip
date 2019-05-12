import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class LocalGridNav extends StatelessWidget {
  final List<CommonModel> navList;

  const LocalGridNav({Key key, this.navList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: _buildNav(context),
      ),
    );
  }

  Widget _buildNav(BuildContext context) {
    if (navList == null) return null;
    var list = navList.map((model) => _item(context, model)).toList();
    return Row(
      children: list,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
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
            width: 32,
            height: 32,
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
    );
  }
}
