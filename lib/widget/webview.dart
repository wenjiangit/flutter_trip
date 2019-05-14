import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  const WebView(
      {Key key,
      this.title,
      @required this.url,
      this.statusBarColor,
      this.hideAppBar})
      : super(key: key);

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
        Container(
          color: Color(int.parse('0xff${widget.statusBarColor ?? 'ffffff'}')),
          height: MediaQuery.of(context).padding.top,
        ),
        Expanded(
            child: WebviewScaffold(
          appBar: widget.hideAppBar ?? false
              ? null
              : AppBar(
                  backgroundColor: Color(
                      int.parse('0xff${widget.statusBarColor ?? '000000'}')),
                  title: Text(widget.title ?? ''),
                ),
          url: widget.url,
          withZoom: true,
          withLocalStorage: true,
          hidden: true,
          initialChild: Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              )),
        ))
      ],
    );
  }
}
