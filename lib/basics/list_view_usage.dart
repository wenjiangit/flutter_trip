import 'package:flutter/material.dart';
import 'base_page.dart';
import 'package:english_words/english_words.dart';

class ListViewUse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListViewUseState();
  }
}

class _ListViewUseState extends State<ListViewUse> {
  List<String> _words;

  final _scrollController = ScrollController();
  int _pageCount = 1;
  bool _isLoadMore = false;

  @override
  void initState() {
    _words = nouns.take(20).toList();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildAppPage(context,
        title: 'ListView使用',
        body: Stack(
          children: <Widget>[
            RefreshIndicator(
                child: ListView(
                  children: _buildList(),
                  controller: _scrollController,
                ),
                onRefresh: _handleRefresh),
            Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  height: _isLoadMore ? 50 : 0,
                  child: CircularProgressIndicator(),
                ))
          ],
        ));
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(Duration(seconds: 1));
    _pageCount = 1;
    setState(() {
      _words = _words.reversed.toList();
    });
  }

  List<Widget> _buildList() {
    return _words.map((word) => _item(word)).toList();
  }

  Widget _item(String word) {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Colors.green),
      margin: EdgeInsets.only(bottom: 2),
      alignment: Alignment.center,
      child: Text(
        word,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  void _loadMore() {
    setState(() {
      _isLoadMore = true;
    });
    Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() {
        var list = List<String>.from(_words);
        list.addAll(nouns.skip(_pageCount * 20).take(20).toList());
        _words = list;
        _pageCount++;
        _isLoadMore = false;
      });
    });
  }
}
