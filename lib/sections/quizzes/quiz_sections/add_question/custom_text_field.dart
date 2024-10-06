import 'package:economics_app/sections/quizzes/quiz_state/add_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../../../app/state/app_state.dart';

class CustomTextField extends ConsumerStatefulWidget {
  const CustomTextField({
    required this.controller,
    this.label,
    super.key,
    this.requireValidation = false,
    this.id,
    this.hintText,
    this.padding = kFormSpacing,
  }) : assert(!requireValidation || id != null,
            'ID must not be null if validation is required');

  final TextEditingController controller;
  final String? label;
  final bool requireValidation;
  final String? id;
  final String? hintText;
  final double padding;

  @override
  ConsumerState<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  bool isValidated = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appState = ref.watch(appProvider);
    final addQuestionNotifier = ref.read(addQuestionProvider.notifier);
    final isDarkTheme = appState.isDarkTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * widget.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: kFormTextLabelPadding,
              child: Text(
                widget.label!,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: isValidated || !widget.requireValidation
                        ? Theme.of(context).colorScheme.primary
                        : Colors.red),
              ),
            ),
          Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    // Shadow color with transparency
                    offset: const Offset(0, 2),
                    // Offset of the shadow (x, y)
                    blurRadius: 6,
                    // How much the shadow should blur
                    spreadRadius: 1, // Spread radius of the shadow
                  ),
                ],
                color: isDarkTheme
                    ? Theme.of(context).colorScheme.surfaceDim
                    : Colors.white,
                borderRadius: BorderRadius.circular(kRadius),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    TextFormField(
                      controller: widget.controller,
                      maxLines: 8,
                      minLines: 1,
                      maxLength: 500,
                      onChanged: widget.requireValidation
                          ? (value) {
                              isValidated = value.trim() != "";
                              addQuestionNotifier.validateInput(
                                  field: MapEntry(widget.id!, isValidated));
                              setState(() {});
                            }
                          : null,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        contentPadding: const EdgeInsets.fromLTRB(10, 3, 50, 3),
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Align(
                      alignment: const Alignment(1.0, 0.0),
                      // Centered vertically
                      child: IconButton(
                        onPressed: () {
                          widget.controller.clear();
                        },
                        icon: Icon(
                          Icons.clear_outlined,
                          color: Theme.of(context).colorScheme.surfaceDim,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
