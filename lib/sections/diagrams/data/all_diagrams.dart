import 'package:economics_app/sections/diagrams/custom_paint/diagrams/comparative_advantage.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/externalities.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/import_quota.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/international_trade.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/monopolistic_competition.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/monopoly.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/perfect_competition.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/ppc_micro.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/production_subsidy.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/taxes_and_subsidies.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:flutter/material.dart';
import '../custom_paint/diagrams/export_subsidy.dart';
import '../custom_paint/diagrams/oligopoly.dart';
import '../custom_paint/diagrams/price_controls.dart';
import '../custom_paint/diagrams/supply_and_demand.dart';
import '../custom_paint/diagrams/tariff.dart';
import '../enums/diagram_subtype.dart';
import '../enums/diagram_type.dart';
import '../enums/unit_type.dart';
import '../models/diagram_bundle.dart';
import '../models/diagram_painter_config.dart';
import '../utils/mixins.dart';
import 'diagram_descriptions.dart';

class AllDiagrams {
  final Size size;
  final ColorScheme colorScheme;

  AllDiagrams({
    required this.size,
    required this.colorScheme,
  });

  List<DiagramBundle> getDiagramBundles({
    DiagramType? type, // optional filtering
  }) {
    final config = DiagramPainterConfig(
      painterSize: size,
      appSize: Size(size.width, size.height),
      colorScheme: colorScheme,
    );

    // Create bundles
    final List<DiagramBundle> allBundles = [
      /// PPC
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.ppcMicro,
        basePainterDiagrams: [
          PPCMicro(
            config: config,
            model: DiagramModel(
                unit: UnitType.micro,
                type: DiagramType.ppcMicro,
                subtype: DiagramSubtype.opportunityCost),
          ),
        ],
      ),

      /// Supply and Demand
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.supplyDemand,
        basePainterDiagrams: [
          SupplyAndDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.supplyDemand,
              subtype: DiagramSubtype.equilibrium,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.supplyDemand,
        basePainterDiagrams: [
          SupplyAndDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.supplyDemand,
              subtype: DiagramSubtype.increaseInDemand,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.supplyDemand,
        basePainterDiagrams: [
          SupplyAndDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.supplyDemand,
              subtype: DiagramSubtype.decreaseInDemand,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.supplyDemand,
        basePainterDiagrams: [
          SupplyAndDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.supplyDemand,
              subtype: DiagramSubtype.increaseInSupply,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.supplyDemand,
        basePainterDiagrams: [
          SupplyAndDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.supplyDemand,
              subtype: DiagramSubtype.decreaseInSupply,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.supplyDemand,
        basePainterDiagrams: [
          SupplyAndDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.supplyDemand,
              subtype: DiagramSubtype.shortage,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.supplyDemand,
        basePainterDiagrams: [
          SupplyAndDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.supplyDemand,
              subtype: DiagramSubtype.surplus,
              description: '',
            ),
          ),
        ],
      ),

      /// Taxes and Subsidies
      DiagramBundle(
        basePainterDiagrams: [
          TaxesAndSubsidies(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.taxesAndSubsidies,
              subtype: DiagramSubtype.perUnitSalesTax,
              description: kFixedPerUnitSalesTax,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          TaxesAndSubsidies(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.taxesAndSubsidies,
              subtype: DiagramSubtype.adValoremSalesTax,
              description: kAdValoremSalesTaxDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          TaxesAndSubsidies(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.taxesAndSubsidies,
              subtype: DiagramSubtype.salesTaxSocialWelfare,
              description: kSalesTaxSocialWelfareDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          TaxesAndSubsidies(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.taxesAndSubsidies,
              subtype: DiagramSubtype.subsidy,
              description: kSubsidyDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          TaxesAndSubsidies(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.taxesAndSubsidies,
              subtype: DiagramSubtype.subsidySocialWelfare,
              description: kSubsidySocialWelfareDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          PriceControls(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.priceControls,
              subtype: DiagramSubtype.priceFloorNationalMinimumWage,
              description: '',
            ),
          ),
        ],
      ),

      DiagramBundle(
        basePainterDiagrams: [
          PriceControls(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.priceControls,
              subtype: DiagramSubtype.priceFloorAgriculturalPurchases,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          PriceControls(
            config,
            DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.priceControls,
              subtype: DiagramSubtype.priceCeiling,
              description: '',
            ),
          ),
        ],
      ),

      /// Externalities
      DiagramBundle(
        basePainterDiagrams: [
          Externalities(
            config: config,
            model: DiagramModel(
              type: DiagramType.externalities,
              subtype: DiagramSubtype.negativeProduction,
              description: kNegativeProductionExternalityDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Externalities(
            config: config,
            model: DiagramModel(
              type: DiagramType.externalities,
              subtype: DiagramSubtype.negativeConsumption,
              description: kNegativeConsumptionExternalityDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Externalities(
            config: config,
            model: DiagramModel(
              type: DiagramType.externalities,
              subtype: DiagramSubtype.positiveProduction,
              description: kPositiveProductionExternalityDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Externalities(
            config: config,
            model: DiagramModel(
              type: DiagramType.externalities,
              subtype: DiagramSubtype.positiveConsumption,
              description: kPositiveConsumptionExternalityDescription,
            ),
          ),
        ],
      ),

      /// Market Power
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.perfectCompetition,
        label: 'Long-Run Equilibrium',
        description: kPerfectCompetitionLongRunEquilibrium,
        basePainterDiagrams: [
          SupplyAndDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.supplyDemand,
              subtype: DiagramSubtype.longRunEquilibrium,
            ),
          ),
          PerfectCompetition(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.perfectCompetition,
              subtype: DiagramSubtype.longRunEquilibrium,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.perfectCompetition,
        label: 'Abnormal Profits',
        description: kPerfectCompetitionAbnormalProfitProcessDescription,
        basePainterDiagrams: [
          SupplyAndDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.supplyDemand,
              subtype: DiagramSubtype.abnormalProfit,
            ),
          ),
          PerfectCompetition(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.perfectCompetition,
              subtype: DiagramSubtype.abnormalProfit,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.perfectCompetition,
        label: 'Losses',
        description: kPerfectCompetitionLossesDescription,
        basePainterDiagrams: [
          SupplyAndDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.supplyDemand,
              subtype: DiagramSubtype.loss,
            ),
          ),
          PerfectCompetition(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.perfectCompetition,
              subtype: DiagramSubtype.loss,
            ),
          ),
        ],
      ),
      DiagramBundle(
        unit: UnitType.micro,
        type: DiagramType.perfectCompetition,
        label: 'Social Welfare',
        description: kPerfectCompetitionSocialWelfareDescription,
        basePainterDiagrams: [
          SupplyAndDemand(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.supplyDemand,
              subtype: DiagramSubtype.socialWelfare,
            ),
          ),
          PerfectCompetition(
            config: config,
            model: DiagramModel(
              unit: UnitType.micro,
              type: DiagramType.perfectCompetition,
              subtype: DiagramSubtype.socialWelfare,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Monopoly(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopoly,
              subtype: DiagramSubtype.abnormalProfit,
              description: kMonopolyAbnormalProfitsDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Monopoly(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopoly,
              subtype: DiagramSubtype.loss,
              description: 'A monopoly can be loss-making',
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Monopoly(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopoly,
              subtype: DiagramSubtype.naturalMonopoly,
              description: kMonopolyNaturalDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Monopoly(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopoly,
              subtype: DiagramSubtype.socialWelfare,
              description: kMonopolyWelfareLossDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          MonopolisticCompetition(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopolisticCompetition,
              subtype: DiagramSubtype.longRunEquilibrium,
              description:
                  kMonopolisticCompetitionLongRunEquilibriumDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          MonopolisticCompetition(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopolisticCompetition,
              subtype: DiagramSubtype.socialWelfare,
              description: kMonopolisticCompetitionWelfareDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          MonopolisticCompetition(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopolisticCompetition,
              subtype: DiagramSubtype.abnormalProfit,
              description: kMonopolisticCompetitionAbnormalProfitDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          MonopolisticCompetition(
            config: config,
            model: DiagramModel(
              type: DiagramType.monopolisticCompetition,
              subtype: DiagramSubtype.loss,
              description: kMonopolisticCompetitionLossDescription,
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Oligopoly(
            config: config,
            model: DiagramModel(
              type: DiagramType.oligopoly,
              subtype: DiagramSubtype.abnormalProfit,
              description: kOligopolyCartelDescription,
            ),
          ),
        ],
      ),

      /// World Trade
      DiagramBundle(
        label: 'International Trade - Exporter',
        description: kInternationalTradeExporterDescription,
        basePainterDiagrams: [
          InternationalTrade(
            config: config,
            model: DiagramModel(
              unit: UnitType.global,
              type: DiagramType.internationalTrade,
              subtype: DiagramSubtype.worldPrice,
              description: kInternationalTradeExporterDescription,
            ),
          ),
          InternationalTrade(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.internationalTrade,
                subtype: DiagramSubtype.exporter,
                description: kInternationalTradeExporterDescription,
              )),
        ],
      ),

      DiagramBundle(
        label: 'International Trade - Importer',
        basePainterDiagrams: [
          InternationalTrade(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.internationalTrade,
                subtype: DiagramSubtype.worldPrice,
                description: kInternationalTradeExporterDescription,
              )),
          InternationalTrade(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.internationalTrade,
                subtype: DiagramSubtype.importer,
                description: kInternationalTradeExporterDescription,
              ))
        ],
      ),

      /// Comparative Advantage
      DiagramBundle(
        basePainterDiagrams: [
          ComparativeAdvantage(
            config: config,
            model: DiagramModel(
              type: DiagramType.comparativeAdvantage,
              subtype: DiagramSubtype.absoluteAdvantage,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          ComparativeAdvantage(
            config: config,
            model: DiagramModel(
              type: DiagramType.comparativeAdvantage,
              subtype: DiagramSubtype.comparativeAdvantage,
              description: '',
            ),
          ),
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          ComparativeAdvantage(
            config: config,
            model: DiagramModel(
              type: DiagramType.comparativeAdvantage,
              subtype: DiagramSubtype.noGainsFromTrade,
              description: '',
            ),
          ),
        ],
      ),
      /// Tariffs
      DiagramBundle(
        basePainterDiagrams: [
          Tariff(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.tariff,
                subtype: DiagramSubtype.standard,
                description: kTariffDescription,
              ))
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          Tariff(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.tariff,
                subtype: DiagramSubtype.socialWelfare,
                description: kTariffWelfareDescription,
              ))
        ],
      ),

      /// Import Quota
      DiagramBundle(
        basePainterDiagrams: [
          ImportQuota(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.importQuota,
                subtype: DiagramSubtype.standard,
                description: kImportQuotaDescription,
              ))
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          ImportQuota(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.importQuota,
                subtype: DiagramSubtype.socialWelfare,
                description: kImportQuotaWelfareDescription,
              ))
        ],
      ),

      /// Production Subsidy
      DiagramBundle(
        basePainterDiagrams: [
          ProductionSubsidy(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.productionSubsidy,
                subtype: DiagramSubtype.standard,
                description: kProductionSubsidyDescription,
              ))
        ],
      ),

      DiagramBundle(
        basePainterDiagrams: [
          ProductionSubsidy(
            config: config,
            model: DiagramModel(
              unit: UnitType.global,
              type: DiagramType.productionSubsidy,
              subtype: DiagramSubtype.socialWelfare,
              description: kProductionSubsidyWelfareDescription,
            ),
          ),
        ],
      ),

      /// Export Subsidy
      DiagramBundle(
        basePainterDiagrams: [
          ExportSubsidy(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.exportSubsidy,
                subtype: DiagramSubtype.standard,
                description: kExportSubsidyDescription,
              ))
        ],
      ),
      DiagramBundle(
        basePainterDiagrams: [
          ExportSubsidy(
              config: config,
              model: DiagramModel(
                unit: UnitType.global,
                type: DiagramType.exportSubsidy,
                subtype: DiagramSubtype.socialWelfare,
                description: kExportSubsidyWelfareDescription,
              ))
        ],
      ),
    ];

    for (int i = 0; i < allBundles.length; i++) {
      List<DiagramModel> tempModels = [];

      for (int j = 0; j < allBundles[i].basePainterDiagrams.length; j++) {
        final diagramIdentifier =
            allBundles[i].basePainterDiagrams[j] as DiagramIdentifierMixin;

        tempModels.add(
          diagramIdentifier.model.copyWith(
            painter: allBundles[i].basePainterDiagrams[j],
          ),
        );
      }

      // Store the result of copyWith back into allBundles if needed
      allBundles[i] = allBundles[i].copyWith(
        diagramModels: tempModels,
      );
    }

    // Optional filter
    if (type != null) {
      return allBundles.where((bundle) {
        return bundle.basePainterDiagrams.any((diagram) =>
            diagram.model.type == type &&
            diagram.model.subtype == diagram.model.subtype);
      }).toList();
    }
    return allBundles.toList();
  }
}
