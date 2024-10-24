import 'package:flutter/services.dart';

Future<List<String>> getAssetFiles(
  String path,
) async {
  final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
  final assetPaths = assetManifest
      .listAssets()
      .where((String key) => key.startsWith(path))
      .toList();

  return assetPaths;
}
