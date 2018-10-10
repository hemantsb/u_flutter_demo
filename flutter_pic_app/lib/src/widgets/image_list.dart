import 'package:flutter/material.dart';
import 'package:flutter_pic_app/src/models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;

  ImageList(this.images);

  @override
  Widget build(context) {
    return ListView.builder(
      itemBuilder: (context, int index) {
        return ImageBorder(images[index]);
      },
      itemCount: images.length,
    );
  }

  ImageBorder(ImageModel image) {
    return Container(
      child: Column(children: <Widget>[
        Padding(child: Image.network(image.url),
          padding: EdgeInsets.only(bottom: 8.0),
        ),
        Text(image.title)
      ],),
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
    );
  }
}
