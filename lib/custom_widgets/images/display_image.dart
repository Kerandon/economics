import 'dart:typed_data';
import 'package:economics_app/utils/helper_methods/firebase_methods.dart';
import 'package:flutter/material.dart';
import '../loading_error/custom_progress_indicator.dart';

class DisplayImage extends StatefulWidget {
  const DisplayImage(
    this.image, {this.padding,
    super.key,
  });

  final String image;
  final double? padding;

  @override
  State<DisplayImage> createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  late final Future<Map<String, Uint8List?>?> _imageFuture;
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
          if(snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Padding(
                padding: widget.padding != null ? EdgeInsets.all(
                    size.width * widget.padding!) : EdgeInsets.zero,
                child: Image.memory(
                  fit: BoxFit.cover,
                  imageBytes!,
                ),
              );
            }else {
              return Image.asset('assets/images/image_not_found.png');
            }
          }
          return const CustomProgressIndicator();
        });
  }
}
