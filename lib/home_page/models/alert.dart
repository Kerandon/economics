

import '../enums/tag.dart';

class Alert {
  final String text;
  final List<Tag>? tags;

  Alert(this.text, {this.tags});
}
