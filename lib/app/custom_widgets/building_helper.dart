import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_chip_button.dart';
import 'package:economics_app/app/enums/firebase_status.dart';
import 'package:flutter/material.dart';

class BuilderHelper extends StatefulWidget {
  const BuilderHelper({
    super.key,
    this.future,
    this.futures,
    this.loadingText = 'In progress...',
    this.onComplete,
    this.onButtonPressed,
  }) : assert(future != null || futures != null,
  'You must provide either `future` or `futures`.'),
        assert(future == null || futures == null,
        'You can only provide one of `future` or `futures`, not both.');

  final Future<void>? future;
  final List<Future<void>>? futures;
  final String loadingText;
  final Function(dynamic)? onComplete;
  final Map<String, VoidCallback>? onButtonPressed;

  @override
  State<BuilderHelper> createState() => _BuilderHelperState();
}
class _BuilderHelperState extends State<BuilderHelper> {
  bool _onCompleteHasBeenCalled = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final Future<void> combinedFuture = widget.future ?? Future.wait(widget.futures!);

    return Scaffold(
      body: SizedBox(
        width: size.width,
        child: FutureBuilder<void>(
          future: combinedFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                WidgetsBinding.instance.addPostFrameCallback((t) {
                  widget.onComplete?.call(FirebaseStatus.error);
                });
              } else {
                if (widget.onComplete != null && !_onCompleteHasBeenCalled) {
                  WidgetsBinding.instance.addPostFrameCallback((t) {
                    _onCompleteHasBeenCalled = true;
                    widget.onComplete?.call(FirebaseStatus.success);
                  });
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.onButtonPressed != null) ...[
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: size.width * kWrapSpacing,
                        children: widget.onButtonPressed!.entries
                            .map((e) => CustomChipButton(
                          label: e.key,
                          onTap: e.value,
                          selected: true,
                        ))
                            .toList(),
                      ),
                      Icon(
                        Icons.check_circle_outline,
                        size: size.height * 0.20,
                        color: Theme.of(context).colorScheme.primary,
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
  }
}
