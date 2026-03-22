class Term {
  final String term;
  final String explanation;
  final Tag? tag;

  Term({required this.term, required this.explanation, this.tag});
}

enum Tag { none, hl, supplement, p1a, p1b, }
