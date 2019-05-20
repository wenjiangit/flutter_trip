import 'package:flutter/material.dart';

enum SearchType { home, search, highlight }

typedef VoidCallback = void Function();

class SearchBar extends StatefulWidget {
  final VoidCallback onTap;
  final String defaultContent;
  final ValueChanged<String> onTextChanged;
  final SearchType searchType;
  final VoidCallback onSpeakTap;

  const SearchBar({
    Key key,
    this.onTap,
    this.defaultContent,
    this.onTextChanged,
    this.searchType = SearchType.search,
    this.onSpeakTap,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _showClear = false;
  static const inactiveColor = Color(0xffA9A9A9);
  static const bgColor = Color(0xffEDEDED);

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: widget.searchType == SearchType.home ? Colors.white : bgColor,
          borderRadius: BorderRadius.circular(
              widget.searchType == SearchType.home ? 15 : 5)),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            size: 24,
            color: widget.searchType == SearchType.home
                ? Colors.blue
                : inactiveColor,
          ),
          Expanded(
              child: TextField(
                  controller: _controller,
                  autofocus: true,
                  onChanged: _onChange,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  enabled: widget.searchType != SearchType.home,
                  decoration: InputDecoration(
                    hintText: widget.defaultContent,
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  ))),
          GestureDetector(
            onTap: () {
              if (_showClear) {
                _controller.text = '';
                _onChange('');
              } else {
                if (widget.onSpeakTap != null) {
                  widget.onSpeakTap();
                }
              }
            },
            child: _showClear
                ? Icon(
                    Icons.close,
                    size: 24,
                    color: widget.searchType == SearchType.home
                        ? Colors.blue
                        : inactiveColor,
                  )
                : Icon(
                    Icons.mic,
                    size: 24,
                    color: Colors.blue,
                  ),
          )
        ],
      ),
    );
  }

  void _onChange(String text) {
    if (text == null || text.length == 0) {
      setState(() {
        _showClear = false;
      });
    } else {
      setState(() {
        _showClear = true;
      });
    }

    if (widget.onTextChanged != null) {
      widget.onTextChanged(text);
    }
  }
}
