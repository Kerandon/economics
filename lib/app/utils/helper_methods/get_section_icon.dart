import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../enums/sections_replace_me.dart';

IconData getSectionIcon(IBSectionOld section) {
  IconData icon;
  switch (section) {
    case IBSectionOld.intro:
      icon = FontAwesomeIcons.bookOpenReader;
    case IBSectionOld.micro:
      icon = FontAwesomeIcons.cartShopping;
    case IBSectionOld.macro:
      icon = FontAwesomeIcons.chartLine;
    case IBSectionOld.global:
      icon = FontAwesomeIcons.globe;
  }
  return icon;
}
