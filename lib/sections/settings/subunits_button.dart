import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/sections/settings/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/utils/models/unit_model.dart';
import '../quizzes/quiz_state/edit_question_state.dart';

class SubunitsButton extends ConsumerWidget {
  const SubunitsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);

    final units =
        editState.filterModel.units?.expand((e) => e.subunits.toList()) ?? [];
    final f = editState.filterModel;
    final subunitsText = f.subunits?.map((e) => e.name).join(', ') ?? '';
    final selectedSubunits = subunitsText.isEmpty ? 'Select subunits' : subunitsText;
    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<UnitModel>(
        customButton: CustomDropdownHeading(selectedSubunits),
          value: (editState.filterModel.units != null &&
                      editState.filterModel.units!.isNotEmpty) &&
                  editState.filterModel.subunits != null &&
                  editState.filterModel.subunits!.isNotEmpty
              ? units.last
              : null,
          isExpanded: true,
          onChanged: editState.filterModel.units == null ||
                  editState.filterModel.units!.isEmpty
              ? null
              : (_) {},
          items: [
            ...units.map(
              (e) {
                return DropdownMenuItem(
                  enabled: false,
                  value: e,
                  child: CustomDropdownContents(e),
                );
              },
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
    final isSelected = editState.filterModel.subunits?.contains(unit) ?? false;
    return InkWell(
      onTap: () {
        final u = editState.filterModel.subunits?.toList() ?? [];
        isSelected ? u.remove(unit) : u.add(unit);
        editNotifier
            .updateFilter(editState.filterModel.copyWith(subunits: u.toList()));
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
