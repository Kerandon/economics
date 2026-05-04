
import '../enums/tag.dart';

class KeyBody {
  final String title;
  final String content;
  final List<Tag>? tags;

  KeyBody({
    required this.title,
    required this.content,
    this.tags,
  });
}