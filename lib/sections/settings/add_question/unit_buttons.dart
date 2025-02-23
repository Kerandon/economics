import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/utils/models/unit_model.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';

class UnitButtons extends ConsumerWidget {
  const UnitButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);

    final units = editState.filterModel.course?.units.toList();

    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<UnitModel>(
          selectedItemBuilder: (context) {
            return editState.course.units.map(
                  (item) {
                    return Container(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        editState.filterModel.units
                                ?.map((e) => e.name)
                                .join(', ') ??
                            '',
                        style: const TextStyle(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    );
                  },
                ).toList();
          },
          hint: Text(
            'Select units',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          value: editState.filterModel.units != null &&
                  editState.filterModel.units!.isNotEmpty
              ? units?.first
              : null,
          isExpanded: true,
          onChanged: (_) {},
          items: [
            if (units != null && units.isNotEmpty)
              ...units.map(
                (e) => DropdownMenuItem(
                  enabled: false,
                  value: e,
                  child: CustomDropdownContents(e),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class CustomDropdownContents extends ConsumerWidget {
  const CustomDropdownContents(
    this.unit, {
    super.key,
  });

  final UnitModel unit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final isSelected = editState.filterModel.units?.contains(unit) ?? false;
    return InkWell(
      onTap: () {
        final u = editState.filterModel.units?.toList() ?? [];
        final s = editState.filterModel.subunits?.toList() ?? [];

// Add or remove the unit based on selection
        if (isSelected) {
          u.remove(unit); // Remove the unit if it's deselected

          // Remove all subunits that belong to the deselected unit
          s.removeWhere((subunit) => unit.subunits.contains(subunit) == true);
        } else {
          u.add(unit); // Add the unit if it's selected
        }

// Update the filter model
        editNotifier.updateFilter(
          editState.filterModel.copyWith(
            units: u,
            subunits: s,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(unit.index.toString()),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                unit.name ?? '',
              ),
            ),
            const SizedBox(width: 16),
            if (isSelected) ...[
              const Icon(Icons.check_box_outlined)
            ] else ...[
              const Icon(Icons.check_box_outline_blank),
            ]
          ],
        ),
      ),
    );
  }
}
