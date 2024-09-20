enum Course {
  ib,
  igcse,
}

extension CourseExtension on Course {
  // Convert enum to text
  String toText() {
    switch (this) {
      case Course.ib:
        return 'IB';
      case Course.igcse:
        return 'IGCSE';
    }
  }

  // Convert text to enum
  static Course fromText(String text) {
    switch (text) {
      case 'ib':
        return Course.ib;
      case 'igcse':
        return Course.igcse;
      default:
        throw Exception('Unknown course: $text');
    }
  }
}
