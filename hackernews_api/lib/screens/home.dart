import 'package:flutter/material.dart';
import 'package:hackernews_api/screens/news_list.dart';
import '../bloc/stories_provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(
        title: "News App",
        home: NewList(),
      ),
    );
  }
}
