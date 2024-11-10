import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:flutter/material.dart';

class BuilderHelper extends StatelessWidget {
  const BuilderHelper({
    super.key,
    required this.future,
    this.loadingText = 'In progress...',
    this.onComplete,
    this.onButtonPressed,
  });

  final Future<void> future;
  final String loadingText;
  final Function? onComplete;
  final Map<String, VoidCallback>? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: FutureBuilder<dynamic>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
              } else {
                if (onComplete != null) {
                  WidgetsBinding.instance.addPostFrameCallback((t) {
                    Navigator.of(context).pop();
                    onComplete?.call();
                  });
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...[
                      if (onButtonPressed != null) ...[
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: size.width * kWrapSpacing,
                          children: onButtonPressed!.entries
                              .map(
                                (e) => CustomChipButton(
                                  text: e.key,
                                  onPressed: () {
                                    e.value.call();
                                  },
                                  isSelected: true,
                                ),
                              )
                              .toList(),
                        ),
                        Icon(
                          Icons.check_circle_outline,
                          size: size.height * 0.20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ],
                  ],
                );
              }
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
