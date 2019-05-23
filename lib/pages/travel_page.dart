import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_dao.dart';
import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:flutter_trip/pages/travel_tab_view.dart';
import 'package:flutter_trip/widget/underline_indicator.dart';

class TravelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage>
    with SingleTickerProviderStateMixin {
  TravelTabModel _travelModel;
  List<TravelTab> _travelTabs = [];
  TabController _controller;

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: TabBar(
              tabs: _tabs(),
              controller: _controller,
              isScrollable: true,
              indicator: UnderlineIndicator(
                  borderSide: BorderSide(
                    width: 3,
                    color: Color(0xff2fcfbb),
                  ),
                  strokeCap: StrokeCap.round),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              labelStyle: TextStyle(fontSize: 16),
              unselectedLabelStyle: TextStyle(fontSize: 15),
            ),
          ),
          Expanded(
              child: TabBarView(
            children: _tabBarViews(),
            controller: _controller,
          ))
        ],
      ),
    );
  }

  void _loadData() {
    TravelDao.fetch().then((TravelTabModel model) {
      _controller = TabController(length: model.tabs.length, vsync: this);
      setState(() {
        _travelModel = model;
        _travelTabs = model.tabs;
      });
    }).catchError((error) {
      print(error);
    });
  }

  _tabs() {
    if (_travelTabs == null) return null;
    return _travelTabs.map((tab) {
      return Tab(
        text: tab.labelName,
      );
    }).toList();
  }

  List<Widget> _tabBarViews() {
    if (_travelTabs == null) return null;
    return _travelTabs.map((e) => _buildTabView(e)).toList();
  }

  Widget _buildTabView(TravelTab tab) {
    return TravelTabView(
      groupChannelCode: tab.groupChannelCode,
      params: _travelModel.params,
      url: _travelModel.url,
    );
  }
}

