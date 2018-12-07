import 'package:flutter/material.dart';
import '../model/item.dart';
import 'dart:async';

class CommentsWidget extends StatelessWidget {
  final int itemID;
  final Map<int, Future<Item>> itemMap;

  CommentsWidget({this.itemID, this.itemMap});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: itemMap[itemID],
        builder: (context, AsyncSnapshot<Item> snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading item");
          }
          final commentsList = <Widget>[];
          commentsList.add(Text(snapshot.data.text));
          snapshot.data.kids.forEach((kidId) {
            commentsList.add(CommentsWidget(itemMap: itemMap, itemID: kidId));
          });

          return Column(children: commentsList);
        });
  }
}
