import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/gap.dart';
import 'package:economics_app/sections/quizzes/quiz_state/add_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddQuestionDropdowns extends ConsumerStatefulWidget {
  const AddQuestionDropdowns({
    super.key,
  });

  @override
  ConsumerState<AddQuestionDropdowns> createState() => _CustomAddUnitsState();
}

class _CustomAddUnitsState extends ConsumerState<AddQuestionDropdowns> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxWidth = size.width - (size.width * (kPageIndentHorizontal * 2));

    final addQuestionState = ref.watch(addQuestionProvider);
    final addQuestionNotifier = ref.read(addQuestionProvider.notifier);

    if (addQuestionState.unit.name == "") {
      if (addQuestionState.course.units.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((t) {
          addQuestionNotifier.setUnit(addQuestionState.course.units.first);
        });
      }
    }

    if (addQuestionState.subunit.name == "") {
      if (addQuestionState.unit.subunits.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((t) {
          addQuestionNotifier.setSubunit(addQuestionState.unit.subunits.first);
        });
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownMenu(
          width: maxWidth,
          initialSelection: addQuestionState.unit,
          dropdownMenuEntries: addQuestionState.course.units
              .map(
                (e) => DropdownMenuEntry(
                  value: e,
                  label: e.name,
                  labelWidget: SizedBox(
                    width: size.width,
                    child: Text(e.name),
                  ),
                ),
              )
              .toList(),
          onSelected: (u) {
            addQuestionNotifier
              ..setUnit(u!)
              ..setSubunit(u.subunits.first);
          },
        ),
        const Gap(),
        DropdownMenu(
          width: maxWidth,
          initialSelection: addQuestionState.subunit,
          dropdownMenuEntries: addQuestionState.unit.subunits
              .map(
                (e) => DropdownMenuEntry(
                  value: e,
                  label: e.name,
                  labelWidget: Text(e.name),
                ),
              )
              .toList(),
          onSelected: (u) {
            addQuestionNotifier.setSubunit(u!);
          },
        ),
      ],
    );
  }
}
