enum Course {
  ib,
  igcse,
}

extension Type on Course {
  String toText() {
    switch (this) {
      case Course.ib:
        return 'IB';
      case Course.igcse:
        return 'IGCSE';
    }
  }
}
