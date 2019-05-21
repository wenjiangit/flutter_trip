import 'package:flutter/material.dart';

enum SearchType { home, search, highlight }

typedef VoidCallback = void Function();

class SearchBar extends StatefulWidget {
  final VoidCallback onTap;
  final String defaultContent;
  final ValueChanged<String> onTextChanged;
  final SearchType searchType;
  final VoidCallback onSpeakTap;
  final Color backgroundColor;

  const SearchBar({
    Key key,
    this.onTap,
    this.defaultContent = '',
    this.onTextChanged,
    this.searchType = SearchType.search,
    this.onSpeakTap,
    this.backgroundColor,
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
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: widget.searchType == SearchType.home
              ? widget.backgroundColor
              : bgColor,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.search,
            size: 22,
            color: widget.searchType == SearchType.home
                ? Colors.blue
                : inactiveColor,
          ),
          Expanded(child: _inputBox()),
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
                    size: 22,
                    color: widget.searchType == SearchType.home
                        ? Colors.blue
                        : inactiveColor,
                  )
                : Icon(
                    Icons.mic,
                    size: 22,
                    color: Colors.blue,
                  ),
          )
        ],
      ),
    );
  }

  Widget _inputBox() {
    return TextField(
      controller: _controller,
      autofocus: widget.searchType != SearchType.home,
      onChanged: _onChange,
      style: TextStyle(fontSize: 18, color: Colors.black),
      enabled: widget.searchType != SearchType.home,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: widget.defaultContent,
        border: InputBorder.none,
        hintStyle: TextStyle(fontSize: 14),
        contentPadding: EdgeInsets.only(top: 10),
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
