import 'package:flutter/material.dart';

class CustomButtonOverlayAppBar extends StatelessWidget {
  const CustomButtonOverlayAppBar({
    super.key,
    required this.title,
    required this.expansionControllers,
  });

  final String title;
  final List<ExpansionTileController> expansionControllers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {

            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              for (var c in expansionControllers) {

                c.collapse();

              }
            });

          },
          child: Center(
              child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          )),
        ),
      ),
    );
  }
}
