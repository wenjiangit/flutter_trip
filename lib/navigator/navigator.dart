import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController();
  static const _defaultColor = Colors.grey;
  static const _activeColor = Colors.blue;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: PageView(
        controller: _controller,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage(),
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _defaultColor,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: _activeColor,
                ),
                title: Text(
                  '首页',
                  style: TextStyle(
                      color: _currentIndex == 0 ? _activeColor : _defaultColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: _defaultColor,
                ),
                activeIcon: Icon(
                  Icons.search,
                  color: _activeColor,
                ),
                title: Text(
                  '搜索',
                  style: TextStyle(
                      color: _currentIndex == 1 ? _activeColor : _defaultColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.camera,
                  color: _defaultColor,
                ),
                activeIcon: Icon(
                  Icons.camera,
                  color: _activeColor,
                ),
                title: Text(
                  '旅拍',
                  style: TextStyle(
                      color: _currentIndex == 2 ? _activeColor : _defaultColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                  color: _defaultColor,
                ),
                activeIcon: Icon(
                  Icons.account_circle,
                  color: _activeColor,
                ),
                title: Text(
                  '我的',
                  style: TextStyle(
                      color: _currentIndex == 3 ? _activeColor : _defaultColor),
                )),
          ]),
    );
  }
}
