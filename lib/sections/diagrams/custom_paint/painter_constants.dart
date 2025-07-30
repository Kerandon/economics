// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

/// Curves
const kCurveWidth = 4.0;
const kCurveWidthSlim = 3.0;
const kArrowSize = 12.0;

/// Axis
const kAxisIndent = 0.20;
const kAxisTextIndent = 0.05;
const kAxisLabelAdjustmentCenter = 2.5;
const kAxisWidth = 0.30;
const kDashedLineWidth = 4.0;

/// Text
const kLabelFontSize = 28.0;
const kFontSize = 24.0;
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

enum DiagramLabel {
  a,
  b,
  c,
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
  sTax,
  sSub,
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
  pD,
  p1,
  p2,
  pc,
  pp,
  pSub,
  q,
  q1,
  q2,
  q3,
  q4,
  qpi,
  pe,
  pme,
  qe,
  qTax,
  qSub,
  qS,
  qD,
  pM,
  shortage,
  surplus,
  dEqualsMPB,
  dEqualsMPBMSB,
  sEqualsMPC,
  sEqualsMPCMSC,
  externality,
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
  goodA,
  goodB,
  sD,
  sDQ,
  sDSub,
  dD,
  sW,
  households,
  firms,
  landLaborCapitalEnterprise,
  householdSpendingFirmRevenue,
  goodsAndServices,
  rentWagesInterestProfit,
  factorMarkets,
  productMarkets,
  government,
  financialSector,
  foreignSector,
  taxes,
  governmentSpending,
  savings,
  investment,
  imports,
  exports,
  sWTariff,
  sWQuota,
  pW,
  pWT,
  pWQ,
  pWS,
  EuroPerDollar,
  quantityOfUSD,
  qUSD,
  supplyOfUSD,
  demandForUSD,
  euroUSD,
  eR,
  eR1,
  eR2,
  eRF,
  ninety,
  ninetyFive,
  oneHundredAndFive,
  exchangeRate,
  quantityOfCurrency,
  upperBand,
  lowerBand,
  tradeBalance,
  tradeSurplus,
  tradeDeficit,
  tradeBalanced,
  time,
  lowIncome,
  lowSavings,
  lowInvestment,
  lowProductivity,
  depreciationDevaluation,
}

extension MicroLabelExtension on DiagramLabel {
  String get label {
    switch (this) {
      case DiagramLabel.p:
        return 'P';
      case DiagramLabel.q:
        return 'Q';
      case DiagramLabel.pe:
        return 'Pe';
      case DiagramLabel.qe:
        return 'Qe';
      case DiagramLabel.d:
        return 'D';
      case DiagramLabel.d1:
        return 'D₁';
      case DiagramLabel.s:
        return 'S';
      case DiagramLabel.s1:
        return 'S₁';
      case DiagramLabel.p1:
        return 'P₁';
      case DiagramLabel.p2:
        return 'P₂';
      case DiagramLabel.q1:
        return 'Q₁';
      case DiagramLabel.q2:
        return 'Q₂';

      case DiagramLabel.s2:
        return 'S₂';
      case DiagramLabel.d2:
        return 'D₂';

      case DiagramLabel.dEqualsMPBMSB:
        return 'D=MPB=MSB';
      case DiagramLabel.mpc:
        return 'S=MPC';
      case DiagramLabel.qS:
        return 'Qs';
      case DiagramLabel.qD:
        return 'Qd';
      case DiagramLabel.pM:
        return 'Pᴹ';

      case DiagramLabel.shortage:
        return 'shortage';
      case DiagramLabel.surplus:
        return 'surplus';
      case DiagramLabel.msc:
        return 'MSC';
      case DiagramLabel.pOpt:
        return 'Popt';
      case DiagramLabel.pm:
        return 'Pm';

      case DiagramLabel.dEqualsMPB:
        return 'D=MPB';
      case DiagramLabel.qOpt:
        return 'Qopt';
      case DiagramLabel.qm:
        return 'Qm';
      case DiagramLabel.priceCostsRevenue:
        return 'Price, costs & revenues (\$)';
      case DiagramLabel.quantityFirm:
        return 'Quantity - Firm';
      case DiagramLabel.d1EqualsAR1MR1:
        return 'D₁=AR₁=MR₁';
      case DiagramLabel.dEqualsARMR:
        return 'D=AR=MR';
      case DiagramLabel.mr:
        return 'MR';
      case DiagramLabel.mc:
        return 'MC';
      case DiagramLabel.msb:
        return 'MSB';
      case DiagramLabel.atc:
        return 'ATC';
      case DiagramLabel.srac:
        return 'SRAC';
      case DiagramLabel.mcEqualsMR:
        return 'MC=MR';
      case DiagramLabel.tablets:
        return 'tablets';
      case DiagramLabel.smartPhones:
        return 'smart phones';
      case DiagramLabel.chairs:
        return 'chairs';
      case DiagramLabel.tables:
        return 'tables';

      case DiagramLabel.sEqualsMPC:
        return 'S=MPC';

      case DiagramLabel.sEqualsMPCMSC:
        return 'S=MPC=MSC';

      case DiagramLabel.sm:
        return 'Sm';
      case DiagramLabel.dm:
        return 'Dm';
      case DiagramLabel.industryQuantity:
        return 'Quantity - Industry';
      case DiagramLabel.pm1:
        return 'Pm₁';
      case DiagramLabel.dm1:
        return 'Dm₁';

      case DiagramLabel.sm1:
        return 'Sm₁';
      case DiagramLabel.sm2:
        return 'Sm₂';
      case DiagramLabel.dm2:
        return 'Dm₂';
      case DiagramLabel.pm2:
        return 'Pm₂';
      case DiagramLabel.sme:
        return 'Dmₑ';
      case DiagramLabel.dme:
        return 'Smₑ';

      case DiagramLabel.pme:
        return 'Pmₑ';
      case DiagramLabel.consumerSurplus:
        return 'Consumer surplus';
      case DiagramLabel.producerSurplus:
        return 'Producer surplus';
      case DiagramLabel.abnormalProfit:
        return 'Abnormal profit';
      case DiagramLabel.loss:
        return 'Loss';
      case DiagramLabel.dEqualsAR:
        return 'D=AR';
      case DiagramLabel.quantity:
        return 'Quantity';
      case DiagramLabel.lrac:
        return 'LRAC';
      case DiagramLabel.welfareLoss:
        return 'Welfare Loss';
      case DiagramLabel.externality:
        return 'Externality';
      case DiagramLabel.qpi:
        return 'Qπ';
      case DiagramLabel.sTax:
        return 'S+Tax';
      case DiagramLabel.pc:
        return 'Pc';
      case DiagramLabel.pp:
        return 'Pp';
      case DiagramLabel.sSub:
        return 'S+Sub';
      case DiagramLabel.qTax:
        return 'QTax';
      case DiagramLabel.qSub:
        return 'QSub';
      case DiagramLabel.sD:
        return 'Sd';
      case DiagramLabel.dD:
        return 'Dd';
      case DiagramLabel.sW:
        return 'Sw';
      case DiagramLabel.pW:
        return 'Pw';
      case DiagramLabel.pWT:
        return 'Pw+t';
      case DiagramLabel.sWTariff:
        return 'Sw + Tariff';
      case DiagramLabel.q3:
        return 'Q3';
      case DiagramLabel.q4:
        return 'Q4';
      case DiagramLabel.sWQuota:
        return 'SW + Quota';
      case DiagramLabel.pWQ:
        return 'Pw+q';
      case DiagramLabel.sDQ:
        return 'Sd+q';
      case DiagramLabel.sDSub:
        return 'Sd+sub';
      case DiagramLabel.pSub:
        return 'P+Sub';
      case DiagramLabel.pWS:
        return 'PW+Sub';
      case DiagramLabel.pD:
        return 'Pd';
      case DiagramLabel.goodA:
        return 'Good A';
      case DiagramLabel.goodB:
        return 'Good B';
      case DiagramLabel.EuroPerDollar:
        return 'Euro € per USD \$';
      case DiagramLabel.quantityOfUSD:
        return 'Qty of USD \$';
      case DiagramLabel.supplyOfUSD:
        return 'Supply of USD \$';
      case DiagramLabel.demandForUSD:
        return 'Demand for USD \$';
      case DiagramLabel.eR1:
        return 'ER₁';
      case DiagramLabel.eR2:
        return 'ER₂';
      case DiagramLabel.eR:
        return 'ER';
      case DiagramLabel.euroUSD:
        return '€ per \$';
      case DiagramLabel.qUSD:
        return 'Q of \$';
      case DiagramLabel.ninety:
        return '0.90';
      case DiagramLabel.ninetyFive:
        return '0.95';
      case DiagramLabel.oneHundredAndFive:
        return '1.05';
      case DiagramLabel.exchangeRate:
        return 'Exchange Rate';
      case DiagramLabel.quantityOfCurrency:
        return 'Qty of Currency';
      case DiagramLabel.eRF:
        return 'ERf';
      case DiagramLabel.lowIncome:
        return 'low Income';
      case DiagramLabel.lowSavings:
        return 'Low Savings';
      case DiagramLabel.lowInvestment:
        return 'Low Investment';
      case DiagramLabel.lowProductivity:
        return 'Low Productivity';
      case DiagramLabel.tradeBalance:
        return 'Trade Balance';
      case DiagramLabel.tradeSurplus:
        return 'Trade\nSurplus\nX > M';
      case DiagramLabel.tradeDeficit:
        return 'Trade\nDeficit\nX < M';
      case DiagramLabel.tradeBalanced:
        return 'X = M';
      case DiagramLabel.time:
        return 'Time';
      case DiagramLabel.depreciationDevaluation:
        return 'Depreciation\n'
            ' / Devaluation';
      case DiagramLabel.a:
        return 'A';
      case DiagramLabel.b:
        return 'B';
      case DiagramLabel.c:
        return 'C';
      case DiagramLabel.upperBand:
      return 'Upper Band';
      case DiagramLabel.lowerBand:
        return 'Lower Band';
      case DiagramLabel.households:
      return 'Households';
      case DiagramLabel.firms:
        return 'Firms';
      case DiagramLabel.factorMarkets:
        return 'Factor Markets';
      case DiagramLabel.productMarkets:
        return 'Product Markets';
      case DiagramLabel.government:
        return 'Government';
      case DiagramLabel.financialSector:
        return 'Financial Sector';
      case DiagramLabel.foreignSector:
        return 'Foreign Sector';
      case DiagramLabel.taxes:
        return 'Taxes';
      case DiagramLabel.governmentSpending:
        return 'Government Spending';
      case DiagramLabel.savings:
        return 'Savings';
      case DiagramLabel.investment:
        return 'Investment';
      case DiagramLabel.imports:
        return 'Imports';
      case DiagramLabel.exports:
        return 'Exports';
      case DiagramLabel.landLaborCapitalEnterprise:
        return 'Factors of Production (Land, Labor, Capital, Enterprise)';
      case DiagramLabel.householdSpendingFirmRevenue:
        return 'Household Spending / Firm Revenue';
      case DiagramLabel.goodsAndServices:
        return 'Goods & Services';
      case DiagramLabel.rentWagesInterestProfit:
        return 'Factor Payments (Rent, Wages, Interest, Profit)';
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
