import 'package:flutter/material.dart';

/// Curves
const kCurveWidth = 5.0;
const kCurveWidthSlim = 3.0;
const kArrowSize = 12.0;

/// Axis
const kAxisIndent = 0.22;
const kAxisLabelAdjustmentCenter = 2.5;
const kAxisWidth = 0.30;
const kDashedLineWidth = 4.0;

/// Text
const kLabelFontSize = 28.0;
const kFontSize = 26.0;
const kLabelTextStyle =
    TextStyle(fontStyle: FontStyle.italic, fontSize: kFontSize * 0.90);

/// Dot
const kDotRadius = 12.0;

/// Micro labels
const kP = 'P';
const kQ = 'Q';
const kDMPBMSB = 'D = MPB = MSB';
const kMPC = 'S=MPC';
const kMSC = 'MSC';
const kPOpt = 'Popt';
const kPm = 'Pm';
const kQOpt = 'Qopt';
const kQm = 'Qm';
const kPriceCostsRevenue = 'Price, costs & revenues (\$)';

const kDAR = 'D = AR';

const kMR = 'MR';
const kMC = 'MC';
const kAC = 'AC';

/// Macro-labels
const kHouseholds = 'Households';
const kFirms = 'Firms';
const kLaborLandCapitalEntrepreneurship =
    'Labor, land, capital & entrepreneurship\n             (factors of production)';
const kWagesRentInterestProfit =
    'Wages, rent, interest, profit\n     (factor payments)';
const kSaleOfGoodsAndServices = 'Sale of goods & services';
const kHouseholdExpenditureFirmRevenue = 'House expenditure / firm revenue';
const kConsumerGoods = 'Consumer goods';
const kCapitalGoods = 'Capital goods';
const kKeynesianAS = 'Keynesian AS';
const kPe = 'Pe';
const kQe = 'Qe';
const kYe = 'Ye';
const kPLe = 'PLe';
const kPriceLevel = 'Price level';
const kAD = 'AD';
const kRealGDP = 'Real GDP';
const kTimeYears = 'Time (years)';
const kPotentialOutput = 'Potential output';
const kPeak = 'Peak';
const kExpansion = 'Expansion';
const kTrough = 'Trough';
const kContraction = 'Contraction';
const kSRAS = 'SRAS';
const kLRAS = 'LRAS';
const kInflationRate = 'Inflation rate';
const kUnemploymentRate = 'Unemployment rate';
const kLRPC = 'LRPC';
const kSRPC = 'SRPC';

/// Global Labels
const kPrice = 'Price';
const kWorldPrice = 'Pw';
const kPWorldTariff = 'Pw + t';
const kWorldSupply = 'Sw';
const kWorldSupplyTariff = 'Sw + tariff';
const kSd = 'Sd';
const kDd = 'Dd';
const kQ1 = 'Q1';
const kQ2 = 'Q2';
const kQ3 = 'Q3';
const kQ4 = 'Q4';
const kSQuota = 'Sd + quota';
const kWorldSupplyQuota = 'Sw + quota';
const kDomesticSupplySubsidy = 'Sd + subsidy';
const kWorldPriceSubsidy = 'Pw + subsidy';
const kCountryA = 'Country A';
const kCountryB = 'Country B';
const kGoodA = 'Good A';
const kGoodB = 'Good B';

const kEuroPerUS = 'EUR / USD';
const kQuantityOfUSD = 'Quantity of USD';
const kDemandForUSD = 'Demand for USD';
const kSupplyOfUSD = 'Supply of USD';
const kS1 = 'S1';
const kD1 = 'D1';
const kS2 = 'S2';
const kD2 = 'D2';
const kIncreasedDemandForUSD = 'Increased demand\nfor USD';
const kExchangeRateEquilibrium = 'e';
const kExchangeRateEquilibrium1 = 'e1';
const kExchangeRateEquilibrium2 = 'e2';
const kExchangeRate = 'Exchange rate';
const kQuantityOfDomesticCurrency = 'Qty of domestic currency';
const kLowIncome = 'Low income';
const kLowSavings = 'Low savings';
const kLowProductivity = 'Low productivity';
const kLowInvestment = 'Low investment';
const kLowPhysicalCapital = 'Low physical capital';
const kLowHumanCapital = 'Low human capital';
const kLowNaturalCapital = 'Low natural capital';

enum MicroLabel {
  consumerSurplus,
  producerSurplus,
  abnormalProfit,
  welfareLoss,
  loss,
  tablets,
  smartPhones,
  chairs,
  tables,
  s,
  sm,
  sme,
  sm1,
  sm2,
  d,
  dm,
  dme,
  dm1,
  dm2,
  s1,
  d1,
  s2,
  d2,
  p,
  p1,
  p2,
  q,
  q1,
  q2,
  pe,
  pme,
  qe,
  qS,
  qD,
  pM,
  shortage,
  surplus,
  dEqualsMPB,
  dEqualsMPBMSB,
  sEqualsMPC,
  sEqualsMPCMSC,
  mpc,
  msc,
  msb,
  pOpt,
  pm,
  pm1,
  pm2,
  qOpt,
  qm,
  priceCostsRevenue,
  industryQuantity,
  quantity,
  quantityFirm,
  dEqualsARMR,
  dEqualsAR,
  d1EqualsAR1MR1,
  mr,
  mc,
  atc,
  srac,
  lrac,
  mcEqualsMR,
}

extension MicroLabelExtension on MicroLabel {
  String get label {
    switch (this) {
      case MicroLabel.p:
        return 'P';
      case MicroLabel.q:
        return 'Q';
      case MicroLabel.pe:
        return 'Pe';
      case MicroLabel.qe:
        return 'Qe';
      case MicroLabel.d:
        return 'D';
      case MicroLabel.d1:
        return 'D₁';
      case MicroLabel.s:
        return 'S';
      case MicroLabel.s1:
        return 'S₁';
      case MicroLabel.p1:
        return 'P₁';
      case MicroLabel.p2:
        return 'P₂';
      case MicroLabel.q1:
        return 'Q₁';
      case MicroLabel.q2:
        return 'Q₂';

      case MicroLabel.s2:
        return 'S2';
      case MicroLabel.d2:
        return 'D2';

      case MicroLabel.dEqualsMPBMSB:
        return 'D=MPB=MSB';
      case MicroLabel.mpc:
        return 'S=MPC';
      case MicroLabel.qS:
        return 'Qs';
      case MicroLabel.qD:
        return 'Qd';
      case MicroLabel.pM:
        return 'Pᴹ';

      case MicroLabel.shortage:
        return 'shortage';
      case MicroLabel.surplus:
        return 'surplus';
      case MicroLabel.msc:
        return 'MSC';
      case MicroLabel.pOpt:
        return 'Popt';
      case MicroLabel.pm:
        return 'Pm';

      case MicroLabel.dEqualsMPB:
        return 'D=MPB';
      case MicroLabel.qOpt:
        return 'Qopt';
      case MicroLabel.qm:
        return 'Qm';
      case MicroLabel.priceCostsRevenue:
        return 'Price, costs & revenues (\$)';
      case MicroLabel.quantityFirm:
        return 'Quantity - Firm';
      case MicroLabel.d1EqualsAR1MR1:
        return 'D₁=AR₁=MR₁';
      case MicroLabel.dEqualsARMR:
        return 'D=AR=MR';
      case MicroLabel.mr:
        return 'MR';
      case MicroLabel.mc:
        return 'MC';
      case MicroLabel.msb:
        return 'MSB';
      case MicroLabel.atc:
        return 'ATC';
      case MicroLabel.srac:
        return 'SRAC';
      case MicroLabel.mcEqualsMR:
        return 'MC=MR';
      case MicroLabel.tablets:
        return 'tablets';
      case MicroLabel.smartPhones:
        return 'smart phones';
      case MicroLabel.chairs:
        return 'chairs';
      case MicroLabel.tables:
        return 'tables';

      case MicroLabel.sEqualsMPC:
        return 'S=MPC';

      case MicroLabel.sEqualsMPCMSC:
        return 'S=MPC=MSC';

      case MicroLabel.sm:
        return 'Sm';
      case MicroLabel.dm:
        return 'Dm';
      case MicroLabel.industryQuantity:
        return 'Quantity - Industry';
      case MicroLabel.pm1:
        return 'Pm₁';
      case MicroLabel.dm1:
        return 'Dm₁';

      case MicroLabel.sm1:
        return 'Sm₁';
      case MicroLabel.sm2:
        return 'Sm₂';
      case MicroLabel.dm2:
        return 'Dm₂';
      case MicroLabel.pm2:
        return 'Pm₂';
      case MicroLabel.sme:
        return 'Dmₑ';
      case MicroLabel.dme:
        return 'Smₑ';

      case MicroLabel.pme:
        return 'Pmₑ';
      case MicroLabel.consumerSurplus:
        return 'Consumer surplus';
      case MicroLabel.producerSurplus:
        return 'Producer surplus';
      case MicroLabel.abnormalProfit:
        return 'Abnormal profit';
      case MicroLabel.loss:
        return 'Loss';
      case MicroLabel.dEqualsAR:
        return 'D=AR';
      case MicroLabel.quantity:
        return 'Quantity';
      case MicroLabel.lrac:
      return 'LRAC';
      case MicroLabel.welfareLoss:
        return 'Welfare Loss';
    }
  }
}

enum MacroLabel {
  v,
  w,
  x,
  y,
  z,
}

extension MacroLabelExtension on MacroLabel {
  String get label {
    switch (this) {
      case MacroLabel.v:
        return 'V';
      case MacroLabel.w:
        return 'W';
      case MacroLabel.x:
        return 'X';
      case MacroLabel.y:
        return 'Y';
      case MacroLabel.z:
        return 'Z';
    }
  }
}
