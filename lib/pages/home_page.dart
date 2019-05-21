import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/banner_model.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';

import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/mid_grid_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/search_bar.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:flutter_trip/widget/webview.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  double _appBarAlpha = 0;

  List<CommonModel> _localNavList = [];
  List<CommonModel> _subNavList = [];
  GridNavModel _gridNavModel;
  SalesBoxModel _salesBoxModel;
  List<BannerModel> _bannerList = [];

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        //移除系统padding
        body: Stack(
          children: <Widget>[
            //添加滑动监听
            NotificationListener(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification &&
                      notification.depth == 0) {
                    _onScroll(notification.metrics.pixels);
                  }
                },
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: RefreshIndicator(
                      displacement: 50,
                      child: _listView,
                      onRefresh: _handleRefresh),
                )),
            _appBar,
          ],
        ));
  }

  Widget get _listView => ListView(
        children: <Widget>[
          _banner,
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6))),
            elevation: 3,
            margin: EdgeInsets.all(8),
            child: LocalGridNav(
              navList: _localNavList,
            ),
          ),
          MidGridNav(
            gridNavModel: _gridNavModel,
          ),
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: SubNav(
              navList: _subNavList,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: SalesBox(
              salesBoxModel: _salesBoxModel,
            ),
          )
        ],
      );

  Widget get _banner {
    return Container(
      height: 160,
      child: Swiper(
        onTap: (index) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebView(
                        url: _bannerList[index].url,
                      )));
        },
        autoplay: true,
        itemCount: _bannerList.length,
        itemBuilder: (context, index) {
          return Image.network(
            _bannerList[index].icon,
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }

  Widget get _appBar {
    final topPadding = MediaQuery.of(context).padding.top;
    Color color = _appBarAlpha < 0.5 ? Colors.white : Colors.black54;
    return Container(
      height: topPadding + 50,
      padding: EdgeInsets.only(top: topPadding),
      decoration: BoxDecoration(
          color: Color.fromARGB((_appBarAlpha * 255).toInt(), 255, 255, 255),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)],
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              '深圳',
              style: TextStyle(color: color),
            ),
          ),
          Icon(
            Icons.expand_more,
            color: color,
          ),
          Expanded(
            child: SearchBar(
              searchType: SearchType.home,
              onTap: () {},
              defaultContent: '网红打卡地 景点 酒店 美食',
              backgroundColor: _appBarAlpha < 0.5 ? Colors.white : Color(0xffEDEDED),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.comment, color: color),
          )
        ],
      ),
    );
  }

  void _onScroll(double offset) {
    var alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      _appBarAlpha = alpha;
    });
  }

  Future<void> _handleRefresh() async {
    try {
      var homeModel = await HomeDao.fetch();
      setState(() {
        _localNavList = homeModel.localNavList;
        _gridNavModel = homeModel.gridNav;
        _subNavList = homeModel.subNavList;
        _salesBoxModel = homeModel.salesBox;
        _bannerList = homeModel.bannerList;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
