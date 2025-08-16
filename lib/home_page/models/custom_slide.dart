import 'custom_slide_content.dart';

class CustomSlide {
  final dynamic section;
  final String? title;
  final List<CustomSlideContent>? contents;
  final bool? hl;

  CustomSlide({this.section, this.title, this.contents, this.hl = false});

  CustomSlide copyWith({
    dynamic section,
    String? title,
    List<CustomSlideContent>? contents,
    bool? hl,
  }) {
    return CustomSlide(
      section: section ?? this.section,
      title: title ?? this.title,
      contents: contents ?? this.contents,
      hl: hl ?? this.hl,
    );
  }
}
