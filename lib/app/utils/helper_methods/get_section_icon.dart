import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../enums/sections.dart';

IconData getSectionIcon(Section section) {
  IconData icon;
  switch (section) {
    case Section.intro:
      icon = FontAwesomeIcons.bookOpenReader;
    case Section.micro:
      icon = FontAwesomeIcons.cartShopping;
    case Section.macro:
      icon = FontAwesomeIcons.chartLine;
    case Section.global:
      icon = FontAwesomeIcons.globe;
  }
  return icon;
}