import 'package:economics_app/home_page/models/slide_content.dart';

class Slide {
  final dynamic section;
  final String? title;
  final List<SlideContent>? contents;
  final bool? hl;

  Slide({this.section, this.title, this.contents, this.hl = false});

  Slide copyWith({
    dynamic section,
    String? title,
    List<SlideContent>? contents,
    bool? hl,
  }) {
    return Slide(
      section: section ?? this.section,
      title: title ?? this.title,
      contents: contents ?? this.contents,
      hl: hl ?? this.hl,
    );
  }
}
