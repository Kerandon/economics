import 'package:economics_app/app/configs/constants.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../../utils/mixins/unit_mixin.dart';
import '../../utils/models/unit.dart';
import '../custom_chip_button.dart';
import '../custom_icon_button.dart';
import '../custom_pop_up.dart';

class CustomExpandablePanelNew extends StatelessWidget {
  const CustomExpandablePanelNew({
    super.key,
    required this.list,
    required this.expandableController,
    required this.idTextController,
    required this.nameTextController,
    this.label,
    this.onAdd,
    this.onRemove,
    this.initialValue,
    this.onSelected,
    this.isDisabled = false,
  });

  final List<UnitMixin> list;
  final ExpandableController expandableController;
  final TextEditingController idTextController;
  final TextEditingController nameTextController;
  final UnitMixin? initialValue;
  final Function(UnitMixin)? onSelected;
  final Function(UnitMixin)? onAdd;
  final Function()? onRemove;
  final bool isDisabled;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Padding(
            padding: kFormTextLabelPadding,
            child: Text(label!,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: isDisabled
                          ? Theme.of(context).colorScheme.surfaceDim
                          : Theme.of(context).colorScheme.primary,
                    )),
          ),
        ],
        ExpandablePanel(
          theme: const ExpandableThemeData(hasIcon: false),
          controller: expandableController,
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownMenu<UnitMixin>(
                key: list.isEmpty ? UniqueKey() : ValueKey(initialValue),
                enabled: !isDisabled,
                width: size.width * 0.70,
                initialSelection:
                    isDisabled || list.isEmpty ? null : initialValue,
                // Check if the list is empty
                onSelected: (UnitMixin? value) {
                  onSelected?.call(value!);
                },
                dropdownMenuEntries: isDisabled || list.isEmpty
                    ? []
                    : // Handle empty list
                    list.map<DropdownMenuEntry<UnitMixin>>((UnitMixin unit) {
                        return DropdownMenuEntry<UnitMixin>(
                          value: unit,
                          label: (unit.index != null &&
                                  unit.index!.trim().isNotEmpty)
                              ? '${unit.index!}   ${unit.name ?? ''}'
                              : (unit.name ?? ''),
                        );
                      }).toList(),
              ),
              SizedBox(
                width: size.width * 0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIconButton(
                      onPressed: () {
                        if (!expandableController.expanded) {
                          expandableController.toggle();
                        }
                      },
                      icon: Icons.add_outlined,
                    ),
                    CustomIconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomPopup(
                            title: 'Remove subunit',
                            actionButtons: [
                              CustomChipButton(
                                  text: 'Confirm',
                                  onPressed: () {
                                    onRemove?.call();
                                  }),
                              CustomChipButton(
                                  text: 'Cancel',
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            ],
                          ),
                        );
                      },
                      icon: Icons.remove_outlined,
                    ),
                  ],
                ),
              ),
            ],
          ),
          collapsed: const SizedBox.shrink(),
          expanded: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Create a new unit'),
              Row(
                children: [
                  // Expanded(
                  //     child: CustomTextField(
                  //         controller: idTextController, label: 'Id')),
                  // Expanded(
                  //     flex: 5,
                  //     child: CustomTextField(
                  //         controller: nameTextController, label: 'Name')),
                  CustomChipButton(
                      text: 'Confirm new unit',
                      onPressed: () {
                        onAdd?.call(
                          Unit(
                              index: idTextController.text,
                              name: nameTextController.text),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Unit ${nameTextController.text} successfully added')));
                        nameTextController.clear();
                        if (expandableController.expanded) {
                          expandableController.toggle();
                        }
                      },
                      isSelected: true),
                  CustomChipButton(
                      text: 'Cancel',
                      onPressed: () {
                        if (expandableController.expanded) {
                          expandableController.toggle();
                        }
                      },
                      isSelected: true)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
