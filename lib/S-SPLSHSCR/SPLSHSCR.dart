import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parbank/S-LGNIDNTY/LGNIDNTY.dart';
import 'package:parbank/helpers/UAsset.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';
import 'package:parbank/helpers/HelperMethods.dart';

class SPLSHSCR extends StatefulWidget {
  const SPLSHSCR({super.key});

  @override
  State<SPLSHSCR> createState() => _SPLSHSCRState();
}

class _SPLSHSCRState extends State<SPLSHSCR> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2, milliseconds: 50), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LGNIDNTY()),(route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColor.PrimaryColor,
      body: Center(child: HelperMethods.ShowAsset(UAsset.LOGO, height: USize.Height/1.5),),
    );
  }
}