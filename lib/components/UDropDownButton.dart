// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class UDropDownButton extends StatelessWidget {
  List<DropdownMenuItem<dynamic>>? items;
  double? width;
  dynamic value;
  String? hintText;
  Widget? prefixIcon;
  Color? prefixColor;
  Color? fillColor;
  String? errorText;
  Function(dynamic)? onChanged;
  UDropDownButton({super.key, this.items, this.width, this.value, this.onChanged, this.errorText, this.fillColor, this.hintText, this.prefixColor, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? USize.Width * 0.73,
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            isDense: true,
              filled: fillColor != null,
              fillColor: errorText != null ? UColor.RedLightColor : fillColor,
              hintText: hintText,
              hintStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
          borderRadius: BorderRadius.circular(12),
          dropdownColor: UColor.WhiteHeavyColor,
          items: items,
          value: value,
          onChanged: onChanged),
    );
  }
}
