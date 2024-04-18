import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import '../articles_models/article_model.dart';

Future<String?> getImage(String path) async {
  try {
    final instance = FirebaseStorage.instance;
    return await instance.ref('$path.png').getDownloadURL();
  } catch (error) {
    return null;
  }
}

Future<Map<String, String>?> getImageURLs(String path) async {
  Future.delayed(const Duration(seconds: 3));

  try {
    Map<String, String> urls = {};
    final ref = FirebaseStorage.instance.ref(path);
    final bucket = await ref.listAll();
    for (var i in bucket.items) {
      urls.addEntries(
          [MapEntry(i.name.split('.').first, await i.getDownloadURL())]);
    }
    return urls;
  } catch (e) {
    return null;
  }
}

Future<List<ArticleModel>?> getArticleDataFromFirebase() async {
  try {
    final ref = FirebaseFirestore.instance;

    final snapshot =
        await ref.collection('articles').doc('articles').get();

    final rawString = snapshot.get('articles');

    List<ArticleModel> articles = parseSections(rawString);
    return articles;
  } catch (e) {
    return null;
  }
}

List<ArticleModel> parseSections(String rawString) {
  List<ArticleModel> articles = [];

  // Define regex pattern to extract data between SECTION tags
  final sectionPattern =
  RegExp(r'<SECT:(.*?):(.*?)>\s*<BODY>(.*?)<\/BODY>');

  // Extract matches using regex
  final sectionMatches = sectionPattern.allMatches(rawString);

  // Loop through matches and create ArticleModel objects
  for (final match in sectionMatches) {
    String title = match.group(1)!;
    String unit = match.group(2)!;
    String body = match.group(3)!;

    articles.add(ArticleModel.copyWith(
      unit: unit,
      title: title,
      body: body,
    ));
  }

  return articles;
}