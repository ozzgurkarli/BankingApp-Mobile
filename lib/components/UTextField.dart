// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class UTextField extends StatelessWidget {
  TextEditingController controller;
  TextInputType? keyboardType;
  double? width;
  bool? obsecureText;
  Function(String)? onChanged;
  Function()? onTap;
  bool? readOnly;
  String? hintText;
  Widget? prefixIcon;
  List<TextInputFormatter>? inputFormatters;
  TextCapitalization? textCapitalization;
  Color? prefixColor;
  Color? fillColor;
  double? fontSize;
  String? errorText;
  int? maxLength;
  UTextField(
      {required this.controller,
      this.keyboardType,
      super.key,
      this.obsecureText,
      this.width,
      this.readOnly,
      this.hintText,
      this.prefixColor,
      this.textCapitalization,
      this.onChanged,
      this.prefixIcon,
      this.fillColor,
      this.fontSize,
      this.errorText,
      this.inputFormatters,
      this.onTap,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? USize.Width * 0.7,
      child: TextField(
        maxLength: maxLength,
        onChanged: onChanged,
        controller: controller,
        onTap: onTap,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType ?? TextInputType.text,
        style: TextStyle(fontSize: fontSize ?? 16, fontWeight: FontWeight.w500),
        obscureText: obsecureText ?? false,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
            filled: fillColor != null,
            isDense: true,
            fillColor: errorText != null ? UColor.RedLightColor : fillColor,
            hintText: hintText,
            alignLabelWithHint: true,
            hintStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: USize.Width * 0.05),
              child: prefixIcon,
            ),
            errorText: errorText,
            errorStyle: const TextStyle(
                color: UColor.RedHeavyColor,
                fontSize: 14,
                fontWeight: FontWeight.w500),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: UColor.RedHeavyColor, width: 3)),
            prefixIconColor:
                errorText != null ? UColor.RedHeavyColor : prefixColor,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
