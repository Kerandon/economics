
import 'dart:convert';

import 'package:flutter/services.dart';

import '../quiz_sections/questions/quiz_models/gif_collection.dart';

Future<GifCollection> getGifs() async {
  final manifestContent = await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(manifestContent);

  // Filter keys that start with the folder and end with .gif
  final correctGifs = manifestMap.keys
      .where((String key) =>
  key.startsWith('assets/gifs/correct') && key.endsWith('.gif'))
      .toList();
  final incorrectGifs = manifestMap.keys
      .where((String key) =>
  key.startsWith('assets/gifs/incorrect') && key.endsWith('.gif'))
      .toList();
  return GifCollection(correctGifs: correctGifs.toList(), incorrectGifs: incorrectGifs.toList());
}
