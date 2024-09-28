import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:flutter/material.dart';

class BuilderHelper extends StatelessWidget {
  const BuilderHelper({
    super.key,
    required this.future,
    this.loadingText = 'In progress...',
    this.onButtonPressed,
  });

  final Future<void> future; // Keep it as Future<void>
  final String loadingText;
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Question added successfully',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    Icon(
                      Icons.check_circle_outline,
                      size: size.height * 0.20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    ...[
                      if (onButtonPressed != null)
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

    // return AlertDialog(
    //   backgroundColor: Colors.transparent,
    //   content: SizedBox(
    //     // width: size.width * 0.20,
    //     // height: size.width * 0.70,
    //     child: FutureBuilder<void>(
    //       future: future,
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return const Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               Expanded(
    //                 flex: 5,
    //                 child: Center(child: CircularProgressIndicator()),
    //               ),
    //             ],
    //           );
    //         } else if (snapshot.connectionState == ConnectionState.done) {
    //           // This is where the future is complete, either successfully or with an error
    //           if (snapshot.hasError) {
    //             // Handle error
    //             result.call(snapshot.error);
    //           } else {
    //             // Handle success
    //             result.call(null); // No data to pass
    //           }
    //           WidgetsBinding.instance.addPostFrameCallback((_) {
    //             Navigator.of(context).pop(); // Close the dialog
    //           });
    //         }
    //         return const SizedBox.shrink();
    //       },
    //     ),
    //   ),
    // );
  }
}
