import 'package:flutter/material.dart';

showQuickPopup(BuildContext context, Widget child) {
  showDialog(context: context, builder: (context) => child);
  Future.delayed(const Duration(milliseconds: 3000), () {
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  });
}
