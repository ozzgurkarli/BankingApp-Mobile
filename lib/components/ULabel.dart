// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/helpers/USize.dart';

class ULabel extends StatelessWidget {
  Widget? child;
  String? label;
  double? labelPadding;
  Widget? tailWidget;
  ULabel(
      {super.key, this.label, this.child, this.labelPadding, this.tailWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        tailWidget == null ? Padding(
                padding: EdgeInsets.only(
                    left: labelPadding ?? USize.Width * 0.01,
                    bottom: USize.Width * 0.01),
                child: UText(
                  label!,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ) :
        SizedBox(
          width: USize.Width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: labelPadding ?? USize.Width * 0.01),
                child: UText(
                  label!,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: labelPadding ?? USize.Width * 0.01,
                    bottom: USize.Width * 0.01),
                child: tailWidget
              ),
            ],
          ),
        ),
        child!
      ],
    );
  }
}
