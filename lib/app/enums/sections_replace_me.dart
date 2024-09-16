enum IBSectionOld { intro, micro, macro, global }

extension GetSection on IBSectionOld {
  String getSectionName() {
    switch (this) {
      case IBSectionOld.intro:
        return 'Introduction to Economics';
      case IBSectionOld.micro:
        return 'Microeconomics';
      case IBSectionOld.macro:
        return 'Macroeconomics';
      case IBSectionOld.global:
        return 'Global Economics';
      default:
        return '';
    }
  }

  String getSectionShortName() {
    switch (this) {
      case IBSectionOld.intro:
        return 'Intro';
      case IBSectionOld.micro:
        return 'Micro';
      case IBSectionOld.macro:
        return 'Macro';
      case IBSectionOld.global:
        return 'Global';
      default:
        return '';
    }
  }
}
