import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../../contants/app_images.dart';

class ImageZoomScreen extends StatefulWidget {
  ImageZoomScreen(  {super.key,
  required this.imageUrl
  });

  String imageUrl;

  @override
  State<ImageZoomScreen> createState() => _ImageZoomScreenState();
}

class _ImageZoomScreenState extends State<ImageZoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('', style: TextStyle(fontSize: 14),),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Stack(
            children: [
              Container(
                  child: Center(
                    child: PhotoView(
                      imageProvider: NetworkImage(widget.imageUrl),
                    ),
                  )
              ),
            ],
          )),
    );
  }
}
