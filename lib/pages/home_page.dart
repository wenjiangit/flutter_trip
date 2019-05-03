import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const List<String> image_urls = [
    'http://pic37.nipic.com/20140110/17563091_221827492154_2.jpg',
    'http://pic53.nipic.com/file/20141115/9448607_175255450000_2.jpg',
    'http://pic34.nipic.com/20131104/13264764_101028322111_2.jpg'
  ];

  double _appBarAlpha = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: ListView(
                children: <Widget>[
                  _banner(),
                  Container(
                    height: 1000,
                    child: Text('haha'),
                  )
                ],
              ),
            )),
        _appBar(),
      ],
    ));
  }

  _banner() {
    return Container(
      height: 160,
      child: Swiper(
        autoplay: true,
        itemCount: image_urls.length,
        itemBuilder: (context, index) {
          return Image.network(
            image_urls[index],
            fit: BoxFit.fill,
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }

  _appBar() {
    return Opacity(
      opacity: _appBarAlpha,
      child: Container(
        height: 70,
        padding: EdgeInsets.only(top: 25),
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Text('首页'),
        ),
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
}
