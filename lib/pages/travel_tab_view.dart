import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/travel_dao.dart';
import 'package:flutter_trip/model/travel_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TravelTabView extends StatefulWidget {
  final String groupChannelCode;
  final Map params;
  final String url;

  const TravelTabView({Key key, this.groupChannelCode, this.params, this.url})
      : super(key: key);

  @override
  _TravelTabViewState createState() => _TravelTabViewState();
}

class _TravelTabViewState extends State<TravelTabView> {
  List<TravelItem> _items = [];
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    TravelDao.fetchContent(widget.url, widget.params, widget.groupChannelCode)
        .then((model) {
      setState(() {
        _items = model.resultList..retainWhere((e) => e.type == 1);
        _totalCount = model.totalCount;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
          heightFactor: 1.0,
          child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: _items?.length ?? 0,
              itemBuilder: _buildItem,
              staggeredTileBuilder: (index) => StaggeredTile.fit(2))),
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
}

class _TravelItem extends StatelessWidget {
  final Article article;

  const _TravelItem({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Card(
            margin: EdgeInsets.all(5),
            elevation: 3,
            child: PhysicalModel(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Image.network(article.images[0].originalUrl),
                      Positioned(
                          left: 10,
                          bottom: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 3),
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
                                  article.pois[0].poiName,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      article.articleTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Color(0xff4f4f4f), fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              ClipOval(
                                child: Image.network(
                                  article.author.coverImage.originalUrl,
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                              Text(
                                article.author.nickName,
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.touch_app,
                                size: 12,
                              ),
                              Text(
                                article.likeCount?.toString() ?? '',
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
