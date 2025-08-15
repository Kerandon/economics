import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../enums/diagram_subtype.dart';

class DiagramModel extends Equatable {
  final DiagramSubtype? subtype;
  final CustomPainter? painter;

  const DiagramModel({this.subtype, this.painter});

  // CopyWith method
  DiagramModel copyWith({DiagramSubtype? subtype, CustomPainter? painter}) {
    return DiagramModel(
      subtype: subtype ?? this.subtype,
      painter: painter ?? this.painter,
    );
  }

  @override
  List<Object?> get props => [subtype]; // <-- Add here
}
