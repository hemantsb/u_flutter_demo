import 'package:flutter/material.dart';
import 'package:hackernews_api/screens/news_list.dart';
import '../bloc/stories_provider.dart';
import 'screen_details.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
      child: MaterialApp(title: "News App", onGenerateRoute: routes),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return NewList();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        final itemId = int.parse(settings.name.replaceFirst("/", ""));
        return ScreenDetails(itemId: itemId);
      });
    }
  }
}
