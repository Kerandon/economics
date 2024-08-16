import 'package:flutter/material.dart';

import '../enums/get_custom_icon.dart';

class UnderConstructionPage extends StatelessWidget {
  const UnderConstructionPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.20, bottom: size.height * 0.05),
          child: getCustomIcon(CustomIcon.construction),
        ),
        const Text(
          'Page is under construction\n\nPlease check back later',
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
