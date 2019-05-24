import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_dao.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/webview.dart';

class TravelTabView extends StatefulWidget {
  final String groupChannelCode;
  final Map params;
  final String url;

  const TravelTabView({Key key, this.groupChannelCode, this.params, this.url})
      : super(key: key);

  @override
  _TravelTabViewState createState() => _TravelTabViewState();
}

class _TravelTabViewState extends State<TravelTabView>
    with AutomaticKeepAliveClientMixin {
  List<TravelItem> _items = [];
  bool _loading = false;
  int _pageIndex = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData(refresh: true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(refresh: false);
      }
    });
  }

  void _loadData({bool refresh}) {
    if (refresh) {
      setState(() {
        _loading = true;
      });
      _pageIndex = 1;
    } else {
      _pageIndex++;
    }
    TravelDao.fetchContent(
            widget.url, widget.params, widget.groupChannelCode, _pageIndex)
        .then((model) {
      setState(() {
        var list = model.resultList
          ..retainWhere((e) => e.type == 1 && e.article != null);
        //下拉刷新
        if (refresh) {
          _items = list;
        }
        //加载更多
        else {
          List<TravelItem> temp = [];
          _items = temp..addAll(_items)..addAll(list);
        }
        _loading = false;
      });
    }).catchError((error) {
      print(error);
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: LoadingContainer(
            loading: _loading,
            child: RefreshIndicator(
                child: StaggeredGridView.countBuilder(
                    controller: _scrollController,
                    crossAxisCount: 4,
                    itemCount: _items?.length ?? 0,
                    itemBuilder: _buildItem,
                    staggeredTileBuilder: (index) => StaggeredTile.fit(2)),
                onRefresh: _onRefresh),
          )),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (_items == null) {
      return null;
    }
    return _TravelItem(
      article: _items[index].article,
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _onRefresh() async {
    _loadData(refresh: true);
  }
}

///卡片item
class _TravelItem extends StatelessWidget {
  final Article article;

  const _TravelItem({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WebView(
              url: article.urls[0].h5Url,
              title: '详情',
            );
          }));
        },
        child: Card(
            child: PhysicalModel(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _buildTop(context),
              Padding(
                padding: EdgeInsets.all(8),
                child: _buildMid(),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: _buildBottom(),
              )
            ],
          ),
        )));
  }

  Widget _buildMid() {
    return Text(
      article.articleTitle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Color(0xff4f4f4f), fontSize: 14),
    );
  }

  Widget _buildBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipOval(
              child: Image.network(
                article.author.coverImage.originalUrl,
                width: 25,
                height: 25,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                article.author.nickName,
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.touch_app,
              size: 12,
              color: Colors.grey,
            ),
            Text(
              article.likeCount?.toString() ?? '',
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildTop(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(
          article.images[0].originalUrl,
          fit: BoxFit.cover,
        ),
//        CachedNetworkImage(imageUrl: article.images[0].originalUrl,
//          placeholder: (context, url) => new CircularProgressIndicator(),
//          errorWidget: (context, url, error) => new Icon(Icons.error),
//        ),
        Positioned(
            left: 10,
            bottom: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.place,
                    size: 12,
                    color: Colors.white,
                  ),
                  Text(
                    article.pois.length > 0 ? article.pois[0].poiName : '未知',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
            ))
      ],
    );
  }
}
