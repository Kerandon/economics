import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/configs/constants.dart';
import 'package:economics_app/utils/helper_methods/sort_string_numbers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/article_model.dart';
import '../../models/unit_model.dart';

Future<QuerySnapshot<Map<String, dynamic>>?> getRawCollectionData(
    String url) async {
  try {
    QuerySnapshot<Map<String, dynamic>> data;
    final ref = FirebaseFirestore.instance;

    data = await ref.collection(url).get();
    return data;
  } catch (e) {
    return null;
  }
}

Future<List<UnitModel>?> getSectionsAndUnitData() async {
  try {
    /// Get data from firebase
    final sections = await getRawCollectionData('/$kSections');

    /// Define a local variable
    List<UnitModel> topics = [];
    for (int i = 0; i < sections!.docs.length; i++) {
      topics.add(UnitModel.fromMap(snapshot: sections.docs[i]));
    }

    /// Iterate through the main topics and get the units for each
    for (int i = 0; i < topics.length; i++) {
      final unitData =
          await getRawCollectionData('/$kSections/${topics[i].title}/$kUnits/');
      List<UnitModel> units = [];
      for (int j = 0; j < unitData!.docs.length; j++) {
        units.add(UnitModel.fromMap(
            snapshot: unitData.docs[j], parent: topics[i].title));
      }
      units.sort((a, b) => sortStringNumbers(a.unit, b.unit));
      topics[i] = topics[i].copyWith(units: units);
    }
    if (topics.isEmpty) {
      return null;
    } else {
      return topics;
    }
  } catch (e) {
    return null;
  }
}

Future<List<ArticleModel>?> getArticlesData(UnitModel topic) async {
  try {
    /// Define a list of [ArticleModel]
    List<ArticleModel> articles = [];

    /// Get the [QuerySnapshot<Map<String, dynamic>>] from firebase
    final snapshot = await getRawCollectionData(
        '/$kSections/${topic.parent}/$kUnits/${topic.title}/$kArticles/');

    if (snapshot != null) {
      for (var a in snapshot.docs) {
        articles.add(ArticleModel.fromMap(map: a.data(), heading: a.id));
      }
    } else {
      return null;
    }

    if(articles.every((element) => element.index != null)) {

     articles.sort((a, b) => a.index!.compareTo(b.index!));
    }
    return articles;
  } catch (e) {
    return null;
  }
}

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
