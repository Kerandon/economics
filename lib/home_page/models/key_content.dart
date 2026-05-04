import 'package:economics_app/home_page/models/term.dart';

import '../enums/tag.dart';

class KeyContent {
  final String title;
  final String content;
  final Tag? tag;

  KeyContent({required this.title, required this.content, this.tag});
}
