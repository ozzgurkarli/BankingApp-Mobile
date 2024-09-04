// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class UIconButton extends StatelessWidget {
  Widget icon = const Placeholder();
  final VoidCallback? onPressed;
  String? tooltip;
  double? iconSize;

  UIconButton(
      {super.key,
      required this.icon,
      this.onPressed,
      this.tooltip,
      this.iconSize});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
        iconSize: iconSize ?? 50,
        splashRadius: 0.01,
        tooltip: tooltip,
        icon: icon);
  }
}
