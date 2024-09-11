// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class USegmentedButton extends StatelessWidget {
  Set<String> selected;
  List<ButtonSegment<String>> segments;
  Function(Set<String>) onSelectionChanged;
  USegmentedButton(
      {super.key, required this.onSelectionChanged, required this.selected, required this.segments});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: USize.Width * 0.7,
      child: SegmentedButton(
          style: ButtonStyle(
              splashFactory: NoSplash.splashFactory,
              elevation: const WidgetStatePropertyAll(8),
              shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(11.25)))),
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return UColor.PrimaryLightColor;
                  }
                  return UColor.WhiteHeavyColor;
                },
              ),
              shadowColor: const WidgetStatePropertyAll(UColor.SecondColor)),
          selectedIcon: const Icon(Icons.check),
          emptySelectionAllowed: false,
          segments: segments,
          onSelectionChanged: onSelectionChanged,
          multiSelectionEnabled: false,
          selected: selected),
    );
  }
}
