import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  final String title;
  String url;
  final String statusBarColor;
  final bool hideAppBar;

  WebView(
      {Key key, this.title, String url, this.statusBarColor, this.hideAppBar}) {

    if (url != null && url.contains('ctrip')) {
      this.url = url.replaceAll('http://', 'https://');
    }
  }

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final FlutterWebviewPlugin webviewPlugin = FlutterWebviewPlugin();

  StreamSubscription<String> _onUrlChanged;

  @override
  void initState() {
    super.initState();
    _onUrlChanged = webviewPlugin.onUrlChanged.listen((url) {
      print(url);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _onUrlChanged.cancel();
    webviewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //状态栏
        Container(
          color: Color(int.parse('0xff${widget.statusBarColor ?? '000000'}')),
          height: MediaQuery.of(context).padding.top,
        ),
        //appBar
        Container(
          child: widget.hideAppBar ?? false ? null : _appbar,
        ),
        Expanded(
            child: WebviewScaffold(
          url: widget.url,
          withZoom: true,
          withLocalStorage: true,
          hidden: true,
          userAgent: 'null',
          initialChild: Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              )),
        ))
      ],
    );
  }

  Widget get _appbar {
    Color textColor;
    Color appbarColor;
    if (widget.statusBarColor == null) {
      appbarColor = Colors.white;
      textColor = Colors.black;
    } else {
      appbarColor = Color(int.parse('0xff${widget.statusBarColor}'));
      textColor = Colors.white;
    }

    return Material(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(color: appbarColor),
            child: Text(
              widget.title ?? '详情',
              style: TextStyle(inherit: false, color: textColor, fontSize: 18),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: textColor,
                ),
              ))
        ],
      ),
    );
  }
}
