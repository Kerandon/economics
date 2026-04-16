import 'package:economics_app/diagrams/enums/unit_type.dart';
import 'package:economics_app/home_page/models/slide_content.dart';
import 'package:economics_app/home_page/models/term.dart';

import '../enums/skill.dart';
class Slide {
  final SyllabusPoint? syllabusPoint;

  // --- Overrides (private) ---
  final Subunit? _subunitOverride;
  final String? _titleOverride;
  final List<Tag>? _tagsOverride;
  final List<Skill>? _skillsOverride;

  // --- Contents is NOT resolved: stored directly ---
  final List<SlideContent>? contents;

  // 🆕 Added the question property
  final String? question;

  Slide({
    this.syllabusPoint,
    Subunit? subunit,
    String? title,
    this.contents,
    List<Tag>? tags,
    List<Skill>? skills,
    this.question, // 🆕 Added to constructor
  }) : _subunitOverride = subunit,
        _titleOverride = title,
        _tagsOverride = tags,
        _skillsOverride = skills;

  // -------------------------
  // Resolved properties
  // -------------------------

  Subunit get subunit =>
      _subunitOverride ?? syllabusPoint?.subunit ?? Subunit.whatIsEconomics;

  String get title => _titleOverride ?? syllabusPoint?.title ?? '';

  List<Skill> get skills =>
      _skillsOverride ?? syllabusPoint?.skills ?? const [];

  // Resolves tags: uses overrides if provided. If not, checks syllabusPoint.
  List<Tag> get tags {
    if (_tagsOverride != null) return _tagsOverride;

    final resolvedTags = <Tag>[];

    // Automatically inherit the HL tag if the syllabus point requires it.
    // (You can delete this if SyllabusPoint has also been updated to use List<Tag>)
    if (syllabusPoint?.hlOnly ?? false) {
      resolvedTags.add(Tag.hl);
    }

    return resolvedTags;
  }

  // -------------------------
  // CopyWith (preserves overrides)
  // -------------------------

  Slide copyWith({
    SyllabusPoint? syllabusPoint,
    Subunit? subunit,
    String? title,
    List<SlideContent>? contents,
    List<Tag>? tags,
    List<Skill>? skills,
    String? question, // 🆕 Added to copyWith parameters
  }) {
    return Slide(
      syllabusPoint: syllabusPoint ?? this.syllabusPoint,
      subunit: subunit ?? _subunitOverride,
      title: title ?? _titleOverride,
      contents: contents ?? this.contents,
      tags: tags ?? _tagsOverride,
      skills: skills ?? _skillsOverride,
      question: question ?? this.question, // 🆕 Maps the copied property
    );
  }
}