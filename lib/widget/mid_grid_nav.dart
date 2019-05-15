import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class MidGridNav extends StatefulWidget {
  final GridNavModel gridNavModel;

  const MidGridNav({Key key, this.gridNavModel}) : super(key: key);

  @override
  _MidGridNavState createState() => _MidGridNavState();
}

class _MidGridNavState extends State<MidGridNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: PhysicalModel(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: _gridNavItems(context, widget.gridNavModel),
        ),
      ),
    );
  }

  List<Widget> _gridNavItems(BuildContext context, GridNavModel model) {
    List<Widget> items = [];
    if (model == null) return items;
    if (model.hotel != null) {
      items.add(_gridNavItem(model.hotel, true));
    }

    if (model.flight != null) {
      items.add(_gridNavItem(model.flight, false));
    }

    if (model.travel != null) {
      items.add(_gridNavItem(model.travel, false));
    }

    return items;
  }

  Widget _gridNavItem(GridNavItem item, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(item.mainItem));
    items.add(_doubleItem(item.item1, item.item2));
    items.add(_doubleItem(item.item3, item.item4));

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

  Widget _mainItem(CommonModel item) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
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
    );
  }

  Widget _doubleItem(CommonModel top, CommonModel bottom) {
    return Column(
      children: <Widget>[
        Expanded(
          child: _item(top, true),
        ),
        Expanded(
          child: _item(bottom, false),
        )
      ],
    );
  }

  Widget _item(CommonModel model, bool first) {
    BorderSide side = BorderSide(color: Colors.white, width: 0.8);
    return _wrapGesture(
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

  Widget _wrapGesture(Widget child, CommonModel model) {
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
