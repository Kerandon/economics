import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

const kAppName = 'IB Econ Toolkit';
const kLevel = 'level';
const kHL = 'HL';
const kHLBrackets = '(HL)';
const kSupplementBrackets = '(SUPPLEMENT)';

const kMultipleChoiceQuestions = 'Multiple Choice Questions';

const kIndex = 'index';
const kTermsGlossary = 'Terms Glossary';
const kDiagrams = 'Diagrams';
const kErrorMessage =
    'Something went wrong - check your internet connection & try again';

/// Layout
const kRadius = 6.0;
const kRadiusBig = 30.0;
const kPageIndentHorizontal = 0.03;
const kPageIndentVertical = 0.03;

const kWrapSpacing = 0.01;

/// Animation
const kPageChangeAnimation = 400;
const kAnimationDuration = 500;

/// Colors
const kBackgroundAlphaLight = 10;
const kHighLightedColor = Colors.red;
const BASE_DIAGRAM_SIZE = 400.0;
const double kTextScale = 1.0;
const PdfColor hlColor = PdfColors.deepOrange900;
const PdfColor hlBgColor = PdfColors.orange50;