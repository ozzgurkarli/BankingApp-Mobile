// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:parbank/components/UText.dart';
import 'package:parbank/helpers/USize.dart';

class ULabel extends StatelessWidget {
  Widget? child;
  String? label;
  ULabel({super.key, this.label, this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: USize.Width * 0.01, bottom: USize.Width * 0.01),
          child: UText(
            "${label!}:",
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        child!
      ],
    );
  }
}
