import 'package:economics_app/app/enums/course.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/custom_widgets/gap.dart';
import '../../../../app/utils/mixins/section_mixin.dart';
import '../../quiz_state/add_question_state.dart';

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

      WidgetsBinding.instance.addPostFrameCallback((e) {
        addQuestionNotifier.setCourse(Course.ib);
      });
    }

    return Column(
      children: [
        DropdownButton(
          value: addQuestionState.section,
          items: addQuestionState.sections,
          onChanged: (e) {
            final s = e as SectionMixin;
            addQuestionNotifier.setSection(s);

            List<DropdownMenuItem> units = [];
            for (var u in s.units) {
              units.add(
                DropdownMenuItem(
                  value: u,
                  child: Text(u.unit),
                ),
              );
            }
            addQuestionNotifier
              ..setUnits(units)
              ..setUnit(e.units.first);
          },
        ),
        const Gap(),
        DropdownButton(
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
