import 'package:economics_app/diagrams/enums/unit_type.dart';
import 'package:economics_app/home_page/models/slide_content.dart';

import '../enums/skill.dart';

class Slide {
  final SyllabusPoint? syllabusPoint;

  // --- Overrides (private) ---
  final Subunit? _subunitOverride;
  final String? _titleOverride;
  final bool? _hlOverride;
  final List<Skill>? _skillsOverride;

  // --- Contents is NOT resolved: stored directly ---
  final List<SlideContent>? contents;

  Slide({
    this.syllabusPoint,
    Subunit? subunit,
    String? title,
    this.contents, // direct store
    bool? hl,
    List<Skill>? skills,
  }) : _subunitOverride = subunit,
       _titleOverride = title,
       _hlOverride = hl,
       _skillsOverride = skills;

  // -------------------------
  // Resolved properties
  // -------------------------

  Subunit get subunit =>
      _subunitOverride ?? syllabusPoint?.subunit ?? Subunit.whatIsEconomics;

  String get title => _titleOverride ?? syllabusPoint?.title ?? '';

  List<Skill> get skills =>
      _skillsOverride ?? syllabusPoint?.skills ?? const [];

  bool get hl => _hlOverride ?? syllabusPoint?.hlOnly ?? false;

  // -------------------------
  // CopyWith (preserves overrides)
  // -------------------------

  Slide copyWith({
    SyllabusPoint? syllabusPoint,
    Subunit? subunit,
    String? title,
    List<SlideContent>? contents,
    bool? hl,
    List<Skill>? skills,
  }) {
    return Slide(
      syllabusPoint: syllabusPoint ?? this.syllabusPoint,
      subunit: subunit ?? _subunitOverride,
      title: title ?? _titleOverride,
      contents: contents ?? this.contents,
      hl: hl ?? _hlOverride,
      skills: skills ?? _skillsOverride,
    );
  }
}
