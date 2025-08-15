import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';

import '../../diagrams/data/all_diagrams.dart';
import '../../diagrams/enums/diagram_bundle_enum.dart';
import '../../diagrams/models/diagram_bundle.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    required this.text,
    this.imageURL,
    this.diagramBundleEnum,
    required this.onTap,
  }) : assert(
         (imageURL == null) != (diagramBundleEnum == null),
         'Either imageURL or diagramBundleEnum must be provided, but not both.',
       );

  final String text;
  final String? imageURL;
  final DiagramBundleEnum? diagramBundleEnum;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    DiagramBundle? diagram;

    if (diagramBundleEnum != null) {
      diagram = AllDiagrams(
        size: size,
        colorScheme: colorScheme,
      ).getDiagramBundle(DiagramBundleEnum.microDemand);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, // no color here to keep shadow crisp
        borderRadius: BorderRadius.circular(kRadius),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Material(
        color: Colors.white, // white background for tile
        borderRadius: BorderRadius.circular(kRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(kRadius),
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(kRadius),
                    ),
                    child: imageURL != null
                        ? Ink.image(
                            image: AssetImage(imageURL!),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            child: Container(), // required
                          )
                        : CustomPaint(
                            painter: diagram!.diagramModels.first.painter,
                            size: Size.infinite,
                          ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
