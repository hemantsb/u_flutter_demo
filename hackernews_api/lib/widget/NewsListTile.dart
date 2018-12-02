import '../model/item.dart';
import 'package:flutter/material.dart';
import '../bloc/stories_provider.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<Item>>> snapshot) {
        if (!snapshot.hasData) {
          return Text("Data is loading");
        }
        return FutureBuilder(
            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<Item> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return Text("Still loading");
              }
              return Text(itemSnapshot.data.title);
            });
      },
    );
  }
}
