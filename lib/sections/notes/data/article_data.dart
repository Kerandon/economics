import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'articles/macro/3.1/a_gdp_gni.dart';
import 'articles/macro/3.1/b_alternative_measures.dart';

HtmlWidget buildAlternativeMeasuresArticle() => const HtmlWidget('test 1');

List<MapEntry<String, Widget>> articleData = [
  buildGDPGNIArticle('3.1a'),
  buildAlternativeMeasures('3.1b')
];
