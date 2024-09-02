// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class UIcon extends StatelessWidget {
  IconData icon;
  Color? color; 

  UIcon(this.icon, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color ?? Colors.black,
    );
  }
}
