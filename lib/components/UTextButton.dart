// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class UTextButton extends StatefulWidget {
  Widget child = const Placeholder();
  final VoidCallback? onPressed;

  UTextButton({super.key, required this.child, this.onPressed});

  @override
  State<UTextButton> createState() => _UTextButtonState();
}

class _UTextButtonState extends State<UTextButton> {
  double scale = 1.0;

  void onTapDown(TapDownDetails details) {
    setState(() {
      scale = 0.95; 
    });
  }

  void onTapUp(TapUpDetails details) {
    setState(() {
      scale = 1.0;
    });
  }

  void onTapCancel() {
    setState(() {
      scale = 1.0; 
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
        child: TextButton(
            style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
            onPressed: widget.onPressed,
            child: widget.child),
      ),
    );
  }
}
