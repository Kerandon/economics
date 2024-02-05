import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:economics_app/configs/constants.dart';
import 'article_model.dart';

class TopicModel {
  final String? parent;
  final String? title;
  final String? unit;
  final bool? isHL;
  final List<String>? summary;
  final Map<String, String>? terms;
  final List<TopicModel>? units;
  final List<ArticleModel>? articles;

  TopicModel({
    this.parent,
    this.title,
    this.unit,
    this.isHL,
    this.summary,
    this.terms,
    this.units,
    this.articles,
  });

  TopicModel copyWith({
    String? parent,
    String? title,
    String? unit,
    bool? isHL,
    List<String>? summary,
    Map<String, String>? terms,
    List<TopicModel>? units,
    List<ArticleModel>? articles,
  }) {
    return TopicModel(
      title: title ?? this.title,
      unit: unit ?? this.unit,
      isHL: isHL ?? this.isHL,
      summary: summary ?? this.summary,
      terms: terms ?? this.terms,
      units: units ?? this.units,
      articles: articles ?? this.articles,
    );
  }

  factory TopicModel.fromMap({
    required QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
    String? parent,
    String? grandparent,
  }) {
    /// Define variables
    String? unit;
    bool? isHL;
    List<String> summary = [];
    Map<String, String> terms = {};
    List<TopicModel> units = [];

    /// Iterate through data and initialize variables
    for (var d in snapshot.data().entries) {
      if (d.key == kUnit) {
        unit = d.value;
      }

      if (d.key == kLevel) {
        isHL = true;
      }

      /// Get summary
      if (d.key == kSummary) {
        for (var e in d.value) {
          summary.add(e);
        }
      }

      if (d.key == kTerms) {
        final t = d.value as Map<String, dynamic>;
        for (var e in t.entries) {
          terms.addAll({e.key: e.value});
        }
      }
    }
    return TopicModel(
        parent: parent,
        title: snapshot.id,
        unit: unit,
        isHL: isHL,
        summary: summary,
        terms: terms,
        units: units);
  }
}

// if (d.key == kUnits) {
//   final t = d.value as Map<String, dynamic>;
//   for (var e in t.entries) {
//     print('entry is ${e.key} and ${e.value}');
//   }
// }
// if(d.key == kArticles){
//   final t = d.value as Map<String, dynamic>;
//   for (var e in t.entries) {
//     print('entry is ${e.key} and ${e.value}');
//   }
// }
