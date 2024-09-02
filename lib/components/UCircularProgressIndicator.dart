import 'package:flutter/material.dart';
import 'package:parbank/helpers/UColor.dart';

class UCircularProgressIndicator extends StatelessWidget {
  const UCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(backgroundColor: UColor.PrimaryColor, strokeAlign: CircularProgressIndicator.strokeAlignCenter, color: UColor.PrimaryLightColor, strokeCap: StrokeCap.round,),
    );
  }
}
