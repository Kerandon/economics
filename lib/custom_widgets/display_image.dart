import 'dart:typed_data';

import 'package:economics_app/configs/constants.dart';
import 'package:economics_app/utils/helper_methods/firebase_methods.dart';
import 'package:flutter/material.dart';

class DisplayImage extends StatefulWidget {
  const DisplayImage(
    this.image, {
    super.key,
  });

  final String image;

  @override
  State<DisplayImage> createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  late final Future<Map<String, Uint8List?>> _imageFuture;
  @override
  void initState() {
    _imageFuture = getImage(widget.image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _imageFuture,
        builder: (context, snapshot) {
          final imageBytes = snapshot.data?.entries.first.value;
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(size.width * kPageIndent),
              child: Image.memory(
                fit: BoxFit.cover,
                imageBytes!,
              ),
            );
          }
          return SizedBox.fromSize();
        });
  }
}
