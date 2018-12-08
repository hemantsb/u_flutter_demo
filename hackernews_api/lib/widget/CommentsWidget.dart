import 'package:flutter/material.dart';
import '../model/item.dart';
import 'dart:async';
import 'package:html2md/html2md.dart' as html2md;
import 'loading_container.dart';

class CommentsWidget extends StatelessWidget {
  final int itemID;
  final Map<int, Future<Item>> itemMap;
  final int depth;

  CommentsWidget({this.itemID, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: itemMap[itemID],
        builder: (context, AsyncSnapshot<Item> snapshot) {
          if (!snapshot.hasData) {
            return LoadingContainer();
          }
          final commentsList = <Widget>[];
          final item = snapshot.data;
          String markdown = html2md.convert(item.text);
          commentsList.add(ListTile(
            title: Text(markdown),
            subtitle: item.by == "" ? Text("Deleted") : Text(item.by),
            contentPadding: EdgeInsets.only(left: depth * 16.0, right: 16),
          ));

          commentsList.add(Divider());
          item.kids.forEach((kidId) {
            commentsList.add(CommentsWidget(
              itemMap: itemMap,
              itemID: kidId,
              depth: depth + 1,
            ));
          });

          return Column(children: commentsList);
        });
  }
}
