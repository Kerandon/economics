import 'package:flutter/material.dart';

import '../quiz_sections/completion/completion_page.dart';

void showCompletionDialog(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((t) {
    showDialog(context: context, builder: (context) => const CompletionPage());
  });
}
