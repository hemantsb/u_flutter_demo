import 'package:flutter/material.dart';
import '../bloc/comments_provider.dart';
import '../model/item.dart';
import 'dart:async';
import '../widget/CommentsWidget.dart';

class ScreenDetails extends StatelessWidget {
  final int itemId;

  ScreenDetails({this.itemId});

  @override
  Widget build(BuildContext context) {
    final commentsBloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: buildBody(commentsBloc),
    );
  }

  buildBody(CommentsBloc bloc) {
    return StreamBuilder(
        stream: bloc.itemWithComment,
        builder: (context, AsyncSnapshot<Map<int, Future<Item>>> snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading Comments");
          }

          final itemFuture = snapshot.data[itemId];

          return FutureBuilder(
              future: itemFuture,
              builder: (context, AsyncSnapshot<Item> itemSnapshot) {
                if (!itemSnapshot.hasData) {
                  return Text("Loading Item");
                }

                return buildList(itemSnapshot.data, snapshot.data);
              });
        });
  }

  buildList(Item item, Map<int, Future<Item>> snapshot) {
    final children = <Widget>[];

    children.add(buildTitle(item));

    final itemChild = item.kids.map((kidsID) {
      return CommentsWidget(itemID: kidsID, itemMap: snapshot, depth:1);
    }).toList();
    children.addAll(itemChild);

    return ListView(
      children: children,
    );
  }

  buildTitle(Item item) {
    return Container(
      margin: EdgeInsets.all(16.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
