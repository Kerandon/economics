import 'package:economics_app/home_page/data/units/1.1_what_is_economics_slides.dart';
import 'package:economics_app/home_page/data/units/1.2_economists_approach_slides.dart';
import 'package:economics_app/home_page/data/units/2.1_demand_slides.dart';
import 'package:economics_app/home_page/data/units/2.2_supply_slides.dart';
import 'package:economics_app/home_page/data/units/2.3_competitive_slides.dart';
import 'package:economics_app/home_page/data/units/2.4_critique_slides.dart';
import 'package:economics_app/home_page/data/units/2.5_elasticity_demand.dart';
import 'package:economics_app/home_page/data/units/2.6_elasticity_supply.dart';
import 'package:economics_app/home_page/data/units/2.7_role_government.dart';
import 'package:economics_app/home_page/data/units/4.1_benefits_of_international_trade_slides.dart';
import 'package:economics_app/home_page/data/units/4.2_types_of_trade.dart';

import '../models/slide.dart';

List<Slide> get allSlides => [
  ...whatIsEconomicsSlides,
  ...economistsApproach,
  ...demandSlides,
  ...supplySlides,
  ...competitiveMarketEquilibrium,
  ...critiqueSlides,
  // ...elasticityDemand,
  // ...elasticitySupply,
  // ...roleOfGovernment,
  // ...benefitsOfInternationalTradeSlides,
  // ...typesOfTradeProtectionSlides,
];
