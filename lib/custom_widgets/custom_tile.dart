import 'dart:typed_data';
import 'package:economics_app/configs/constants.dart';
import 'package:economics_app/utils/helper_methods/firebase_methods.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatefulWidget {
  const CustomTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

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
    final size = MediaQuery.of(context).size;
    return FutureBuilder<Map<String, Uint8List?>>(
        future: _imageFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final imageBytes = snapshot.data?.entries.first.value;
            return Stack(
              children: [
                if (imageBytes != null)
                  SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(kRadius),
                      child: Image.memory(
                        fit: BoxFit.cover,
                        imageBytes,
                      ),
                    ),
                  ),
                Align(
                  alignment: const Alignment(0, 0.80),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(kRadius)),
                    child: Padding(
                      padding: EdgeInsets.all(size.width * 0.02),
                      child: Text(
                        widget.title,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                ),
                Align(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        widget.onTap.call();
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
