
import '../../../../../app/utils/models/unit_model.dart';
import '../../../quiz_enums/topic_tag.dart';

class FilterModel {
  final List<UnitModel>? units;
  final List<UnitModel>? subunits;
  final List<TopicTag>? topicTags;

  FilterModel({
    this.units,
    this.subunits,
    this.topicTags,
  });

  // copyWith method
  FilterModel copyWith({
    List<UnitModel>? units,
    List<UnitModel>? subunits,
    List<TopicTag>? topicTags,
  }) {
    return FilterModel(
      units: units ?? this.units,
      subunits: subunits ?? this.subunits,
      topicTags: topicTags ?? this.topicTags,
    );
  }
}
