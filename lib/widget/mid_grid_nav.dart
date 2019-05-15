import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class MidGridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const MidGridNav({Key key, this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: PhysicalModel(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(6),
        child: Column(
          children: _gridNavItems(context, gridNavModel),
        ),
      ),
    );
  }

  List<Widget> _gridNavItems(BuildContext context, GridNavModel model) {
    List<Widget> items = [];
    if (model == null) return items;
    if (model.hotel != null) {
      items.add(_gridNavItem(context, model.hotel, true));
    }

    if (model.flight != null) {
      items.add(_gridNavItem(context, model.flight, false));
    }

    if (model.travel != null) {
      items.add(_gridNavItem(context, model.travel, false));
    }

    return items;
  }

  Widget _gridNavItem(BuildContext context, GridNavItem item, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, item.mainItem));
    items.add(_doubleItem(context, item.item1, item.item2));
    items.add(_doubleItem(context, item.item3, item.item4));

    List<Widget> expandList = items
        .map((e) => Expanded(
              child: e,
              flex: 1,
            ))
        .toList();
    Color startColor = Color(int.parse('0xff${item.startColor}'));
    Color endColor = Color(int.parse('0xff${item.endColor}'));

    return Container(
      height: 88,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(
        children: expandList,
      ),
    );
  }

  Widget _mainItem(BuildContext context, CommonModel item) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Image.network(
              item.icon,
              fit: BoxFit.contain,
              alignment: AlignmentDirectional.bottomCenter,
              height: 88,
              width: 121,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                item.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        item);
  }

  Widget _doubleItem(
      BuildContext context, CommonModel top, CommonModel bottom) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(context, top, true),
        ),
        Expanded(
          child: _item(context, bottom, false),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model, bool first) {
    BorderSide side = BorderSide(color: Colors.white, width: 0.8);
    return _wrapGesture(
        context,
        FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border(left: side, bottom: first ? side : BorderSide.none)),
            alignment: Alignment.center,
            child: Text(
              model.title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        model);
  }

  Widget _wrapGesture(BuildContext context, Widget child, CommonModel model) {
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
      child: child,
    );
  }
}
