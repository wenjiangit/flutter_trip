import 'package:flutter/material.dart';

Widget buildAppPage(BuildContext context,
    {String title = '', @required Widget body}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    ),
    body: body,
  );
}
