import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pic_app/src/models/image_model.dart';
import 'package:flutter_pic_app/src/widgets/image_list.dart';
import 'package:http/http.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images =[];

  void fetchImages() async {
    counter++;
    var response =
        await get('https://jsonplaceholder.typicode.com/photos/$counter');
    var imageModel = ImageModel.fromJson(json.decode(response.body));

    setState(() {
      images.add(imageModel);
    });
  }

  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: ImageList(images),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: fetchImages,
        ),
        appBar: AppBar(
          title: Text("Lets see some images"),
        ),
      ),
    );
  }
}
