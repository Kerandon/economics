import 'package:economics_app/home_page/models/term.dart';

import '../enums/tag.dart';

class Tip {
  final String text;
  final List<Tag>? tags;

  Tip(this.text, {this.tags});
}
