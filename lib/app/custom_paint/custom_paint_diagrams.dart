import 'package:economics_app/app/custom_paint/diagrams/circular_flow_closed.dart';
import 'package:economics_app/app/custom_paint/diagrams/world_trade_quotas.dart';
import 'package:economics_app/app/custom_paint/paint_enums/ppc_types.dart';
import 'package:economics_app/app/custom_paint/paint_enums/world_trade_types.dart';
import 'package:flutter/material.dart';
import 'diagrams/ad.dart';
import 'diagrams/ad_increase.dart';
import 'diagrams/adsras.dart';
import 'diagrams/business_cycle.dart';
import 'diagrams/keynesian_adas.dart';
import 'diagrams/ppc.dart';
import 'diagrams/world_trade_tariff.dart';

class CustomPaintDiagrams extends StatefulWidget {
  const CustomPaintDiagrams({super.key});

  @override
  State<CustomPaintDiagrams> createState() => _CustomPaintGraphsState();
}

class _CustomPaintGraphsState extends State<CustomPaintDiagrams> {
  final List<CustomPainter> _diagrams = [
    WorldTradeQuotas(WorldTradeType.quotaStandard),
    WorldTradeQuotas(WorldTradeType.quotaLabels),
    WorldTradeQuotas(WorldTradeType.quotaCalculation),
    WorldTradeTariff(WorldTradeType.tariffStandard),
    WorldTradeTariff(WorldTradeType.tariffLabels),
    WorldTradeTariff(WorldTradeType.tariffCalculation),
    PPC(type: PPCType.standard),
    PPC(type: PPCType.growth),
    CircularFlowClosed(),
    // ClassicalEquilibrium(),
    BusinessCycle(),
    KeynesianADAS(),
    AD(),
    ADIncrease(),
    ClassicalADAS(),
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
