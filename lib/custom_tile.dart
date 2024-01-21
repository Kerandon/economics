import 'dart:typed_data';

import 'package:economics_app/utils/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatefulWidget {
  const CustomTile({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {

  late final Future<Map<String, Uint8List?>> _imageFuture;

  @override
  void initState() {
    _imageFuture = getImage(widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, Uint8List?>>(
      future: _imageFuture,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final imageBytes = snapshot.data?.entries.first.value as Uint8List?;
          return Column(
            children: [
              // Assuming 'imageBytes' is the Uint8List you obtained
              if (imageBytes != null)
                Image.memory(
                  imageBytes!,
                  width: 100, // Adjust the width as needed
                  height: 100, // Adjust the height as needed
                ),
              const SizedBox(height: 8), // Adjust spacing
              Text(
                widget.title,
                style: TextStyle(color: Colors.white),
              ),
            ],

          );
        }
        return Center(child: CircularProgressIndicator());
      }
    );
  }
}
Future<Map<String, Uint8List?>> getImage(String image) async {
  final instance = FirebaseStorage.instance;

  print('get image $image');

  Map<String, Uint8List?> imageBytes = {};

  try {
    final bytes = await instance.ref('$image.png').getData();
    imageBytes.addAll({image: bytes});
  } catch (error) {
    print('Error fetching image: $error');
    // Handle the error as needed
  }

  return imageBytes;
}

