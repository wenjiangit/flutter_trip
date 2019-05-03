import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '旅拍',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
