import 'package:economics_app/sections/quizzes/quiz_state/add_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../../../app/state/app_state.dart';

class CustomTextField extends ConsumerStatefulWidget {
  const CustomTextField({
    required this.controller,
    required this.hintText,
    super.key,
    this.requireValidation = false,
  });

  final TextEditingController controller;
  final String hintText;
  final bool requireValidation;

  @override
  ConsumerState<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends ConsumerState<CustomTextField> {
  bool _addedToValidationOnInit = false;

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appProvider);
    final addQuestionNotifier = ref.read(addQuestionProvider.notifier);
    final isDarkTheme = appState.isDarkTheme;

    if (widget.requireValidation) {
      if (!_addedToValidationOnInit) {
        _addedToValidationOnInit = true;
        WidgetsBinding.instance.addPostFrameCallback((t) {
          addQuestionNotifier
              .updateValidation(MapEntry(widget.hintText, false));
        });
      }
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color with transparency
            offset: const Offset(0, 2), // Offset of the shadow (x, y)
            blurRadius: 6, // How much the shadow should blur
            spreadRadius: 1, // Spread radius of the shadow
          ),
        ],
        color: isDarkTheme ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(kRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            TextFormField(
              controller: widget.controller,
              maxLines: 8,
              minLines: 3,
              maxLength: 500,
              validator: widget.requireValidation
                  ? (value) {
                _validateInput(
                    notifier: addQuestionNotifier,
                    controller: widget.controller,
                    hintText: widget.hintText);

                return null;
              }
                  : null,
              onChanged: widget.requireValidation
                  ? (value) {
                _validateInput(
                    controller: widget.controller,
                    notifier: addQuestionNotifier,
                    hintText: widget.hintText);
              }
                  : null,
              decoration: InputDecoration(
                labelText: widget.requireValidation
                    ? '*${widget.hintText}'
                    : widget.hintText,
                border: InputBorder.none,
                counterText: '',
              ),
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Align(
              alignment: const Alignment(1.0, 0.0), // Centered vertically
              child: IconButton(
                onPressed: () {
                  widget.controller.clear();
                  _validateInput(
                      controller: widget.controller,
                      notifier: addQuestionNotifier,
                      hintText: widget.hintText);
                },
                icon: const Icon(Icons.clear_outlined),
              ),
            ),
          ],
        ),
      )

    );
  }
}

void _validateInput({
  required AddQuestionNotifier notifier,
  required TextEditingController controller,
  required String hintText,
}) {
  bool valid = false;

  if (controller.text.isEmpty) {
    valid = false; // Set validation status to false
  } else {
    valid = true; // Set validation status to true
  }

  WidgetsBinding.instance.addPostFrameCallback((t) {
    notifier.updateValidation(MapEntry(hintText, valid));
  });
}
