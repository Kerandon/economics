/// Curves
const kCurveWidth = 5.0;
const kCurveWidthSlim = 3.0;
const kArrowSize = 8.0;

/// Axis
const kAxisIndent = 0.15;
const kAxisLabelAdjustmentCenter = 2.5;
const kAxisWidth = 0.30;
const kDashedLineWidth = 4.0;

/// Text
const kLabelFontSize = 28.0;
const kFontSize = 26.0;

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
const kQuantity = 'Quantity (units)';
const kDAR = 'D = AR';
const kPARMR = 'P = AR = MR';
const kMR = 'MR';
const kMC = 'MC';
const kAC = 'AC';
const kSRAC = 'SRAC';
const kMCMR = 'MC = MR';

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
  tablets,
  smartPhones,
  chairs,
  tables,
  s,
  d,
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
  qOpt,
  qm,
  priceCostsRevenue,
  quantity,
  dEqualsAR,
  pEqualsDARMR,
  mr,
  mc,
  ac,
  srac,
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
      case MicroLabel.quantity:
        return 'Quantity (units)';
      case MicroLabel.dEqualsAR:
        return 'D=AR';
      case MicroLabel.pEqualsDARMR:
        return 'P=D=AR=MR';
      case MicroLabel.mr:
        return 'MR';
      case MicroLabel.mc:
        return 'MC';
      case MicroLabel.msb:
        return 'MSB';
      case MicroLabel.ac:
        return 'AC';
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
