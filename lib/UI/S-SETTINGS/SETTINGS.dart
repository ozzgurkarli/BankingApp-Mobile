import 'package:flutter/material.dart';
import 'package:parbank/components/UIcon.dart';
import 'package:parbank/components/UIconButton.dart';
import 'package:parbank/components/UScaffold.dart';
import 'package:parbank/helpers/UColor.dart';

class SETTINGS extends StatefulWidget {
  const SETTINGS({super.key});

  @override
  State<SETTINGS> createState() => _SETTINGSState();
}

class _SETTINGSState extends State<SETTINGS> {
  @override
  Widget build(BuildContext context) {
    return UScaffold(
      leading: UIconButton(
        icon: UIcon(
          Icons.arrow_circle_left_outlined,
          color: UColor.WhiteHeavyColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
