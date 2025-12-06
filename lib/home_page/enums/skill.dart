enum Skill { a01, a02, a03, a04 }

extension SkillExtension on Skill {
  String get label => name.toUpperCase();
}
