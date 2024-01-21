import 'dart:typed_data';
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
          if (snapshot.hasData) {
            final imageBytes = snapshot.data?.entries.first.value;
            return Column(
              children: [
                // Assuming 'imageBytes' is the Uint8List you obtained
                if (imageBytes != null)
                  Image.memory(
                    imageBytes,
                    width: 100, // Adjust the width as needed
                    height: 100, // Adjust the height as needed
                  ),
                const SizedBox(height: 8), // Adjust spacing
                Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}

Future<Map<String, Uint8List?>> getImage(String image) async {
  final instance = FirebaseStorage.instance;

  Map<String, Uint8List?> imageBytes = {};

  try {
    final bytes = await instance.ref('$image.png').getData();
    imageBytes.addAll({image: bytes});
  } catch (error) {}

  return imageBytes;
}
