enum Section { intro, micro, macro, global }

extension GetSection on Section {
  String getSectionName() {
    switch (this) {
      case Section.intro:
        return 'Introduction to Economics';
      case Section.micro:
        return 'Microeconomics';
      case Section.macro:
        return 'Macroeconomics';
      case Section.global:
        return 'Global Economics';
      default:
        return '';
    }
  }
}
