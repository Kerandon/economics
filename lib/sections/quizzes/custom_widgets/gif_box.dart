import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../app/animation/confetti_animation.dart';
import '../../../../app/utils/helper_methods/get_asset_files.dart';

class GifBox extends StatefulWidget {
  const GifBox({super.key, required this.filesUrl});

  final String filesUrl;

  @override
  State<GifBox> createState() => _GifBoxState();
}

class _GifBoxState extends State<GifBox> {
  late final Future<List<String>> _countFilesFuture;

  @override
  void initState() {
    _countFilesFuture = getAssetFiles(widget.filesUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _countFilesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final gifsList = snapshot.data;
          if (gifsList!.isNotEmpty) {
            final r = Random().nextInt(gifsList.length);
            final gif = gifsList[r];
            return Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                      fit: BoxFit.fitHeight, alignment: Alignment.center, gif),
                ),
                const ConfettiAnimation(),
              ],
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
