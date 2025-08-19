
import 'package:economics_app/home_page/data/units/2.1_demand_slides.dart';
import 'package:economics_app/home_page/data/units/2.2_supply_slides.dart';
import 'package:economics_app/home_page/data/units/4.1_benefits_of_international_trade_slides.dart';
import 'package:economics_app/home_page/data/units/4.2_types_of_trade.dart';

import '../models/slide.dart';

List<Slide> get allSlides => [
  ...demandSlides,
  ...supplySlides,
  ...benefitsOfInternationalTradeSlides,
  ...typesOfTradeProtectionSlides,
];
