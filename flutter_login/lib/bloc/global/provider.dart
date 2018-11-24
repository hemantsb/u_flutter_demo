import 'package:flutter/material.dart';
import 'screen/blocs.dart';

class Provider extends InheritedWidget {
  final bloc = Blocs();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Blocs of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}
