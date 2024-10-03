import 'package:economics_app/app/custom_widgets/gap.dart';
import 'package:economics_app/app/utils/mixins/unit_mixin.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../../../../app/custom_widgets/drop_down/custom_expandable_panel.dart';
import '../../../../app/utils/models/unit.dart';

class CustomAddUnits extends StatefulWidget {
  const CustomAddUnits({
    super.key,
  });

  @override
  State<CustomAddUnits> createState() => _CustomAddUnitsState();
}

class _CustomAddUnitsState extends State<CustomAddUnits> {
  final List<ExpandableController> _expandableControllers = [];
  final List<TextEditingController> _textControllers = [];

  UnitMixin selectedUnit = Unit(name: ''), selectedSubunit = Unit(name: '');

  List<UnitMixin> units = [
    Unit(name: 'Apple', subunits: [Unit(name: 'Seed'), Unit(name: 'seed 2')]),
    Unit(name: 'Banana', subunits: [])
  ];

  List<UnitMixin> subunits = [];

  @override
  void initState() {
    for (int i = 0; i < 4; i++) {
      _textControllers.add(TextEditingController());
      if (i < 2) {
        _expandableControllers
            .add(ExpandableController(initialExpanded: false));
      }
    }
    if (units.isNotEmpty) {
      selectedUnit = units.first;
    }
    if (selectedUnit.subunits.isNotEmpty) {
      selectedSubunit = units.first.subunits.first;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedUnit.subunits.isNotEmpty) {
      subunits.clear();
      subunits.addAll(selectedUnit.subunits.toList());
    } else {
      subunits.clear();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomExpandablePanelNew(
          label: 'Select unit',
          isDisabled: units.isEmpty,
          initialValue: selectedUnit,
          list: units,
          expandableController: _expandableControllers[0],
          idTextController: _textControllers[0],
          nameTextController: _textControllers[1],
          onAdd: (unit) {
            units.add(unit);
            selectedUnit = unit;
            setState(() {});
          },
          onRemove: () {
            units.remove(selectedUnit);
            if (units.isNotEmpty) {
              selectedUnit = units.first;
            }
            setState(() {});
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Unit successfully removed'),
              ),
            );
          },
          onSelected: (value) {
            selectedUnit = value;
            setState(() {});
          },
        ),
        const Gap(),
        CustomExpandablePanelNew(
          label: 'Select subunit',
          isDisabled: subunits.isEmpty,
          list: subunits,
          expandableController: _expandableControllers[1],
          idTextController: _textControllers[2],
          nameTextController: _textControllers[3],
          onAdd: (value) {
            setState(() {
              for (int i = 0; i < units.length; i++) {
                if (units[i] == selectedUnit) {
                  units[i].subunits.add(value);
                }
              }
            });
          },
          onRemove: () {
            for (var u in units) {
              if (u == selectedUnit) {
                selectedUnit.subunits.remove(selectedSubunit);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$selectedSubunit successfully removed'),
                  ),
                );
              }
            }
            setState(() {});
          },
          onSelected: (value) {
            selectedSubunit = value;
            setState(() {});
          },
          initialValue: subunits.isNotEmpty ? subunits.first : null,
        )
      ],
    );
  }
}
