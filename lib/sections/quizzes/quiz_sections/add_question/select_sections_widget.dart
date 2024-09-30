import 'package:economics_app/sections/quizzes/quiz_sections/add_question/custom_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/custom_widgets/gap.dart';
import '../../../../app/utils/mixins/unit_mixin.dart';
import '../../quiz_state/add_question_state.dart';
import '../methods/create_units_dropdown_menu_items.dart';

class SelectSectionsWidget extends ConsumerStatefulWidget {
  const SelectSectionsWidget({super.key});

  @override
  ConsumerState<SelectSectionsWidget> createState() =>
      _SelectSectionsWidgetState();
}

class _SelectSectionsWidgetState extends ConsumerState<SelectSectionsWidget> {
  bool _setSectionsOnInit = false;

  @override
  Widget build(BuildContext context) {
    final addQuestionState = ref.watch(addQuestionProvider);
    final addQuestionNotifier = ref.read(addQuestionProvider.notifier);

    if (!_setSectionsOnInit) {
      _setSectionsOnInit = true;

      WidgetsBinding.instance.addPostFrameCallback((t) {
        if (addQuestionState.units.isEmpty) {
          addQuestionNotifier.setCourseOnFirstInit();
        } else {
          addQuestionNotifier
            ..setSection(addQuestionState.section)
            ..setUnits(addQuestionState.units.toList())
            ..setUnit(addQuestionState.unit);
        }
      });
    }

    return Column(
      children: [
        CustomDropDown(
          value: addQuestionState.section,
          items: addQuestionState.sections,
          onChanged: (e) {
            final s = e as UnitMixin;
            addQuestionNotifier.setSection(s);

            List<DropdownMenuItem<dynamic>> units =
                createUnitsDropdownMenuItems(s);
            addQuestionNotifier
              ..setUnits(units)
              ..setUnit(e.subUnits.skip(1).first);
          },
        ),
        const Gap(),
        CustomDropDown(
          value: addQuestionState.unit,
          items: addQuestionState.units,
          onChanged: (e) {
            addQuestionNotifier.setUnit(e);
          },
        ),
      ],
    );
  }
}
