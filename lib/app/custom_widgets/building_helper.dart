import 'package:flutter/material.dart';

class BuilderHelper extends StatelessWidget {
  const BuilderHelper({
    super.key,
    required this.future,
    required this.result,
    this.text = 'In progress...',
  });

  final Future<void> future; // Keep it as Future<void>
  final Function(dynamic) result;
  final String text;

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: SizedBox(
        // width: size.width * 0.20,
        // height: size.width * 0.70,
        child: FutureBuilder<void>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 5,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              // This is where the future is complete, either successfully or with an error
              if (snapshot.hasError) {
                // Handle error
                result.call(snapshot.error);
              } else {
                // Handle success
                result.call(null); // No data to pass
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop(); // Close the dialog
              });
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
