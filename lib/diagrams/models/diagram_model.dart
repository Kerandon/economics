import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../enums/diagram_subtype.dart';

class DiagramModel extends Equatable {
  final DiagramSubtype? subtype;
  final DiagramBundleEnum? diagramBundleEnum;
  final CustomPainter? painter;

  const DiagramModel({this.subtype, this.painter, this.diagramBundleEnum});

  // CopyWith method
  DiagramModel copyWith({DiagramSubtype? subtype, CustomPainter? painter, DiagramBundleEnum? diagramBundleEnum}) {
    return DiagramModel(
      subtype: subtype ?? this.subtype,
      diagramBundleEnum: diagramBundleEnum ?? this.diagramBundleEnum,
      painter: painter ?? this.painter,
    );
  }

  @override
  List<Object?> get props => [subtype, diagramBundleEnum]; // <-- Add here
}
