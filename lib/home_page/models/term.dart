class Term {
  final String term;
  final String explanation;
  final Tag? tag;

  Term({required this.term, required this.explanation, this.tag});
}

enum Tag { hl, supplement }
