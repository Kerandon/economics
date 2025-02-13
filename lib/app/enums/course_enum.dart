enum CourseEnum {
  ib,
  igcse,
}

extension CourseEnumExtension on CourseEnum {
  String toText() {
    switch (this) {
      case CourseEnum.ib:
        return 'IB Economics';
      case CourseEnum.igcse:
        return 'IGCSE';
    }
  }

  static CourseEnum fromText(String text) {
    switch (text) {
      case 'ib':
        return CourseEnum.ib;
      case 'igcse':
        return CourseEnum.igcse;
      default:
        throw Exception('Unknown course: $text');
    }
  }

  static CourseEnum fromFirebase(String text) {
    switch (text) {
      case 'IB Economics':
        return CourseEnum.ib;
      case 'IGCSE Economics':
        return CourseEnum.igcse;
      default:
        throw Exception('Unknown course: $text');
    }
  }
}
