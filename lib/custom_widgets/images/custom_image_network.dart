import 'package:flutter/material.dart';

class CustomImageNetwork extends StatelessWidget {
  const CustomImageNetwork(
    this.uri, {
    super.key,
  });

  final String uri;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageDimension = size.width;
    return SizedBox(
      width: imageDimension,
      height: imageDimension,
      child: Image.network(
        uri.toString(),
        fit: BoxFit.scaleDown,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: (loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!)
                  .toDouble(),
            ),
          );
        },
      ),
    );
  }
}
