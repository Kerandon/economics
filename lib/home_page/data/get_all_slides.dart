import 'package:economics_app/home_page/data/units/1.1_what_is_economics_slides.dart';
import 'package:economics_app/home_page/data/units/1.2_economists_approach_slides.dart';
import 'package:economics_app/home_page/data/units/2.10_asymmetric_info.dart';
import 'package:economics_app/home_page/data/units/2.11_market_power.dart';
import 'package:economics_app/home_page/data/units/2.12_inability_achieve_equity.dart';
import 'package:economics_app/home_page/data/units/2.1_demand_slides.dart';
import 'package:economics_app/home_page/data/units/2.2_supply_slides.dart';
import 'package:economics_app/home_page/data/units/2.3_competitive_slides.dart';
import 'package:economics_app/home_page/data/units/2.4_critique_slides.dart';
import 'package:economics_app/home_page/data/units/2.5_elasticity_demand.dart';
import 'package:economics_app/home_page/data/units/2.6_elasticity_supply.dart';
import 'package:economics_app/home_page/data/units/2.7_role_government.dart';
import 'package:economics_app/home_page/data/units/2.8_externalities.dart';
import 'package:economics_app/home_page/data/units/2.9_public_goods.dart';
import 'package:economics_app/home_page/data/units/4.1_benefits_of_international_trade_slides.dart';
import 'package:economics_app/home_page/data/units/4.2_trade_protection.dart';
import '../models/slide.dart';

List<Slide> get allSlides => [
  // ...whatIsEconomicsSlides,
  // ...economistsApproach,
  ...demandSlides,
  ...supplySlides,
  ...competitiveMarketEquilibrium,
  ...critiqueSlides,
  ...elasticityDemandSlides,
  ...elasticitySupplySlides,
  ...roleOfGovernmentSlides,
  ...externalitiesSlides,
  // ...publicGoodsSlides,
  // ...asymmetricInfoSlides,
  // ...marketPowerSlides,
  // ...inabilityAchieveEquitySlides,
  // ...benefitsOfInternationalTradeSlides,
  // ...typesOfTradeProtectionSlides,
];
