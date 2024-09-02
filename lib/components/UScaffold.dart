// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:parbank/S-LGNIDNTY/LGNIDNTY.dart';
import 'package:parbank/helpers/HelperMethods.dart';
import 'package:parbank/helpers/UAsset.dart';
import 'package:parbank/helpers/UColor.dart';
import 'package:parbank/helpers/USize.dart';

class UScaffold extends StatelessWidget {
  Widget? body;
  List<Widget>? actions;
  Widget? title;
  FloatingActionButton? floatingActionButton;

  UScaffold({super.key, this.body, this.actions, this.floatingActionButton, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UColor.WhiteColor,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(30))),
        leadingWidth: USize.Width / 4.5,
        toolbarHeight: USize.Height / 13,
        title: title,
        leading: Padding(
          padding: EdgeInsets.only(left: USize.Width / 44),
          child: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LGNIDNTY()),
                  (route) => false);
            },
            child: HelperMethods.ShowAsset(UAsset.LOGO_WITH_SIDE_TEXT,
                width: USize.Width, height: USize.Height),
          ),
        ),
        actions: actions,
        backgroundColor: UColor.PrimaryColor,
      ),
      body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(child: body)),
      floatingActionButton: floatingActionButton,
    );
  }
}
