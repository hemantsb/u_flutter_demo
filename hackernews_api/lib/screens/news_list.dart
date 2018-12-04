import 'package:flutter/material.dart';
import '../bloc/stories_provider.dart';
import '../widget/NewsListTile.dart';
import '../widget/refresh.dart';

class NewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    bloc.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text('Top List'),
      ),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
        stream: bloc.topIds,
        builder: (context, AsyncSnapshot<List<int>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Refresh(
            child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  bloc.fetchItem(snapshot.data[index]);
                  return NewsListTile(itemId: snapshot.data[index]);
                }),
          );

//          return ListView.builder(
//              itemCount: snapshot.data.length,
//              itemBuilder: (context, int index) {
//                bloc.fetchItem(snapshot.data[index]);
//                return NewsListTile(itemId: snapshot.data[index]);
//              });
        });
  }
}
