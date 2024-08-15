import 'package:economics_app/sections/diagrams/custom_paint/custom_paint_diagrams.dart';
import 'package:economics_app/sections/diagrams/custom_paint/diagrams/macro_business_cycle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

MapEntry<String, Widget> buildGDPGNIArticle(String id) => MapEntry(
      id,
      Column(
        children: [
          const HtmlWidget(
            ''
            '<h3>GNI GDP test</h3>'
            'GDP refers to Gross Domestic Product'
            '<ol>'
            '<li>Fat</li>'
            '<li>Fat</li>'
            '</ol>',
          ),
          DiagramBox(customPainter: MacroBusinessCycle())
        ],
      ),
    );
