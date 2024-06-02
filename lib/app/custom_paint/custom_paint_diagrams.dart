import 'package:economics_app/app/custom_paint/paint_enums/world_trade_types.dart';
import 'package:flutter/material.dart';

import 'diagrams/global/world_trade_export_subsidies.dart';
import 'diagrams/global/world_trade_production_subsidies.dart';
import 'diagrams/global/world_trade_quotas.dart';
import 'diagrams/global/world_trade_tariff.dart';

class CustomPaintDiagrams extends StatefulWidget {
  const CustomPaintDiagrams({super.key});

  @override
  State<CustomPaintDiagrams> createState() => _CustomPaintGraphsState();
}

class _CustomPaintGraphsState extends State<CustomPaintDiagrams> {
  final List<CustomPainter> _diagrams = [
    WorldTradeExportSubsidies(WorldTradeType.subsidiesExportStandard),
    WorldTradeProductionSubsidies(WorldTradeType.subsidiesProductionStandard),
    WorldTradeProductionSubsidies(
        WorldTradeType.subsidiesProductionCalculation),
    WorldTradeQuotas(WorldTradeType.quotaStandard),
    WorldTradeQuotas(WorldTradeType.quotaLabels),
    WorldTradeQuotas(WorldTradeType.quotaCalculation),
    WorldTradeTariff(WorldTradeType.tariffStandard),
    WorldTradeTariff(WorldTradeType.tariffLabels),
    WorldTradeTariff(WorldTradeType.tariffCalculation),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        children: _diagrams.map((e) => DiagramBox(customPainter: e)).toList());
  }
}

class DiagramBox extends StatelessWidget {
  const DiagramBox({
    super.key,
    required this.customPainter,
  });

  final CustomPainter customPainter;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.width,
      child: CustomPaint(
        painter: customPainter,
      ),
    );
  }
}
