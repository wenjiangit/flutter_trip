import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';
import 'package:flutter_trip/widget/webview.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBoxModel;

  const SalesBox({Key key, this.salesBoxModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: PhysicalModel(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        child: _buildBox(context),
      ),
    );
  }

  Widget _buildBox(BuildContext context) {
    if (salesBoxModel == null) return null;
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Image.network(
                  salesBoxModel.icon,
                  fit: BoxFit.contain,
                  height: 20,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebView(
                                url: salesBoxModel.moreUrl,
                              )));
                },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                          colors: [Colors.red, Colors.pinkAccent[100]])),
                  child: Text(
                    '获取更多福利 >',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        _doubleItem(
            context, salesBoxModel.bigCard1, salesBoxModel.bigCard2, true),
        _doubleItem(
            context, salesBoxModel.smallCard1, salesBoxModel.smallCard2, false),
        _doubleItem(
            context, salesBoxModel.smallCard3, salesBoxModel.smallCard4, false),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model, bool big, bool first) {
    BorderSide side = BorderSide(width: 0.8, color: Color(0xfff2f2f2));
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
            child: Container(
              height: big ? 129 : 80,
              decoration: BoxDecoration(
                  border:
                      Border(right: first ? side : BorderSide.none, top: side)),
              child: Image.network(
                model.icon,
                fit: BoxFit.fill,
              ),
            )));
  }

  Widget _doubleItem(
      BuildContext context, CommonModel left, CommonModel right, bool big) {
    return Row(
      children: <Widget>[
        _item(context, left, big, true),
        _item(context, right, big, false)
      ],
    );
  }
}
