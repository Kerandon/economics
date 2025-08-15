enum DiagramLabel {
  a,
  b,
  c,
  d,
  e,
  consumerSurplus,
  producerSurplus,
  abnormalProfit,
  welfareLoss,
  loss,
  tablets,
  phones,
  soccerBalls,
  volleyBalls,
  pPC1,
  pPC2,
  s,
  sTax,
  sSub,
  sm,
  sme,
  sm1,
  sm2,
  dm,
  dme,
  dm1,
  dm2,
  s1,
  d1,
  demand,
  dMarket,
  supply,
  s2,
  s3,
  d2,
  d3,
  p,
  price,
  price$,
  pD,
  p1,
  p2,
  pc,
  pp,
  pSub,
  q,
  quantityOfChocolateBars,
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
  factorsOfProduction,
  factorPayments,
  landLaborCapitalEnterprise,
  householdSpending,
  householdSpendingFirmRevenue,
  goodsAndServices,
  leakages,
  injections,
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
  interestRate,
  quantityOfMoney,
  sM,
  dM,
  sM1,
  sM2,
  imports,
  exports,
  monetaristsNewClassical,
  keynesian,
  priceLevel,
  realGDP,
  potentialOutput,
  timeYears,
  aggregateDemand,
  aD,
  aD1,
  aD2,
  aD3,
  inflationRate,
  unemploymentRate,
  sRPC,
  lRPC,
  aggregateSupply,
  keynesianAS,
  aS,
  shortRunAggregateSupply,
  sRAS,
  longRunAggregateSupply,
  lRAS,
  pL,
  yF,
  yE,
  yInf,
  yDef,
  sWTariff,
  sWQuota,
  pW,
  pWT,
  pWQ,
  pWS,
  euroPerDollar,
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
        return 'Price,\nCosts,\nRevenues\n(\$)';
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
        return 'Tablets';
      case DiagramLabel.phones:
        return 'Phones';
      case DiagramLabel.soccerBalls:
        return 'Soccer Balls';
      case DiagramLabel.volleyBalls:
        return 'Volley Balls';

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
      case DiagramLabel.euroPerDollar:
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
        return 'Govt. Spending';
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
      case DiagramLabel.factorsOfProduction:
        return 'Factors of Production';
      case DiagramLabel.factorPayments:
        return 'Factor Payments';
      case DiagramLabel.householdSpending:
        return 'Household Spending';
      case DiagramLabel.leakages:
        return 'Leakages';
      case DiagramLabel.injections:
        return 'Injections';
      case DiagramLabel.priceLevel:
        return 'Price Level';
      case DiagramLabel.realGDP:
        return 'Real GDP';
      case DiagramLabel.aggregateDemand:
        return 'Aggregate Demand';
      case DiagramLabel.aD:
        return 'AD';
      case DiagramLabel.aggregateSupply:
        return 'AS';
      case DiagramLabel.aS:
        return 'AS';
      case DiagramLabel.shortRunAggregateSupply:
        return 'Short-Run Aggregate Supply';
      case DiagramLabel.sRAS:
        return 'SRAS';
      case DiagramLabel.longRunAggregateSupply:
        return 'Long-Run Aggregate Supply';
      case DiagramLabel.lRAS:
        return 'LRAS';
      case DiagramLabel.pL:
        return 'PL'; // Common Y-axis label in AD/AS diagrams
      case DiagramLabel.yF:
        return 'Yf'; // Full capacity output
      case DiagramLabel.yInf:
        return 'Yinf'; // Output beyond full employment
      case DiagramLabel.yDef:
        return 'Ydef'; // Output below full employment
      case DiagramLabel.keynesianAS:
        return 'Keynesian AS';
      case DiagramLabel.monetaristsNewClassical:
        return 'Monetarist/New Classical Model';
      case DiagramLabel.keynesian:
        return 'Keynesian Model';
      case DiagramLabel.aD1:
        return 'AD1';
      case DiagramLabel.aD2:
        return 'AD2';
      case DiagramLabel.aD3:
        return 'AD3';
      case DiagramLabel.interestRate:
        return 'Interest Rate';
      case DiagramLabel.quantityOfMoney:
        return 'Quantity of Money';
      case DiagramLabel.sM:
        return 'Sm';
      case DiagramLabel.dM:
        return 'Dm';
      case DiagramLabel.sM1:
        return 'Sm1';
      case DiagramLabel.sM2:
        return 'Sm2';
      case DiagramLabel.inflationRate:
        return 'Inflation Rate';
      case DiagramLabel.unemploymentRate:
        return 'Unemployment Rate';
      case DiagramLabel.lRPC:
        return 'LRPC';
      case DiagramLabel.potentialOutput:
        return 'Potential Output';
      case DiagramLabel.timeYears:
        return 'Time (Years)';
      case DiagramLabel.price:
        return 'Price';
      case DiagramLabel.sRPC:
        return 'SRPC';
      case DiagramLabel.yE:
        return 'Ye';
      case DiagramLabel.e:
        return 'E';
      case DiagramLabel.pPC1:
        return 'PPC1';
      case DiagramLabel.pPC2:
        return 'PPC2';
      case DiagramLabel.demand:
        return 'Demand';
      case DiagramLabel.d3:
        return 'D3';
      case DiagramLabel.supply:
        return 'Supply';
      case DiagramLabel.s3:
        return 'S3';
      case DiagramLabel.price$:
        return 'Price\n(\$)';
      case DiagramLabel.quantityOfChocolateBars:
        return 'Quantity of Choc. Bars';
      case DiagramLabel.dMarket:
        return 'D (Market)';
    }
  }
}
