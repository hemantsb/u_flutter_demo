import 'package:flutter/material.dart';

class DividerContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: ContainerGrey(),
          subtitle: ContainerGrey(),
          trailing: Column(
            children: <Widget>[Icon(Icons.comment)],
          ),
        ),
        Divider(
          height: 8.0,
        )
      ],
    );
  }

  Widget ContainerGrey() {
    return Container(
      color: Colors.grey[200],
      height: 24.0,
      width: 150.0,
    );
  }
}
