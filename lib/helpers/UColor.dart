// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class UColor
{
  static const Color SecondColor = Color(0xFFC3B091);
  static const Color SecondHeavyColor = Color(0xFF6C5E31);
  static const Color PrimaryColor = Color(0xFF2A52BE);
  static const Color PrimaryLightColor = Color(0xFF7EA6FF);
  static const Color WhiteColor = Color(0xFFEFEFEF);
  static const Color WhiteHeavyColor = Color(0xFFD0D0D0);
  static const Color BarrierColor = Color(0xBB000000);
  static const Color RedLightColor = Color(0xFFFf4744);
  static const Color RedColor = Color(0xFFFE1D1D);
  static const Color RedHeavyColor = Color(0xFFB11B1B);

  static const List<List<Color>> CardGradients = [ [], GoldPlusGradient, MidnightPrestigeGradient];
  static const List<Color> GoldPlusGradient = [ Color(0xFFF0C800), Color(0xFFB18F24),];
  static const List<Color> MidnightPrestigeGradient = [ Color(0xFF4B0082), Color(0xFF8b0000), Color(0xFF000033), Color(0xFF4B0082)];
}