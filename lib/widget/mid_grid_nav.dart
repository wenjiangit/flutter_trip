import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';

class MidGridNav extends StatefulWidget {
  final GridNavModel gridNavModel;

  const MidGridNav({Key key, this.gridNavModel}) : super(key: key);

  @override
  _MidGridNavState createState() => _MidGridNavState();
}

class _MidGridNavState extends State<MidGridNav> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _gridNavItems(context, widget.gridNavModel),
    );
  }

  _gridNavItems(BuildContext context, GridNavModel model) {
    List<Widget> items = [];
    if (model == null) return items;
    if (model.hotel != null) {}

    if (model.flight != null) {}

    if (model.travel != null) {}
  }

  _gridNavItem(GridNavItem item) {
    List<Widget> items = [];
    items.add(_mainItem(item.mainItem));
    items.add(_doubleItem(item.item1, item.item2));
  }

  Widget _mainItem(CommonModel item) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: <Widget>[
          Image.network(
            item.icon,
            fit: BoxFit.contain,
            alignment: AlignmentDirectional.bottomCenter,
          ),
          Text(
            item.title,
            style: TextStyle(color: Colors.white, fontSize: 14),
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
      onTap: () {},
      child: child,
    );
  }
}
