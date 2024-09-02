// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class UText extends StatelessWidget {
  String text; 
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;

  UText(this.text, {super.key, this.color, this.fontSize, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: TextAlign.center, style: TextStyle(color: color ?? Colors.black, fontSize: fontSize ?? 16, fontWeight: fontWeight ?? FontWeight.normal),);
  }
}