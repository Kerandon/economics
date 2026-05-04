

import '../enums/tag.dart';

class Body {
  final String text;
  final List<Tag>? tags;

  Body(this.text, {this.tags});
}