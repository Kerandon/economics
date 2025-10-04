import '../../../app/configs/constants.dart';
import '../../../diagrams/enums/unit_type.dart';
import '../../models/slide.dart';
import '../../models/slide_content.dart' show SlideContent;

List<Slide> get roleOfGovernment =>
    [
Slide
(
section: Subunit.elasticityDemand,
title: kKeyTerms,
contents: [
  SlideContent.term(
    'Command and Control',
    'refers to government laws and regulations which must be followed.',
  ),
  SlideContent.term(
    'Direct Provision',
    'is when the government supplies a good directly.',
  ),
])];



