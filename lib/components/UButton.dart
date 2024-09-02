// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:parbank/helpers/UColor.dart';

class UButton extends StatefulWidget {
  final VoidCallback? onPressed;
  Widget? child;
  bool? redButton;

  UButton(
      {super.key,
      required this.onPressed,
      this.redButton,
      required this.child,});
  @override
  State<UButton> createState() => _UButtonState();
}

class _UButtonState extends State<UButton> {
  double scale = 1;

  void onTapDown(TapDownDetails details) {
    setState(() {
      scale =  0.9;
    });
  }

  void onTapUp(TapUpDetails details) {
    setState(() {
      scale = 1;
    });
  }

  void onTapCancel() {
    setState(() {
      scale = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 500),
        child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ButtonStyle(
                splashFactory: NoSplash.splashFactory,
                elevation: const MaterialStatePropertyAll(8),
                shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(11.25)))),
                backgroundColor: widget.redButton == null ? const MaterialStatePropertyAll(UColor.PrimaryColor) : const MaterialStatePropertyAll(UColor.RedColor),
                shadowColor: const MaterialStatePropertyAll(UColor.SecondColor)),
            child: widget.child),
      ),
    );
  }
}
