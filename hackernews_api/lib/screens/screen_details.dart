import 'package:flutter/material.dart';

class ScreenDetails extends StatelessWidget {
  final int itemId;

  ScreenDetails({this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Text("$itemId"),
    );
  }
}
